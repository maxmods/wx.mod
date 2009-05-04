// Scintilla source code edit control
/** @file LexBasic.cxx
 ** Lexer for BlitzMax.
 **/
// Copyright 1998-2003 by Neil Hodgson <neilh@scintilla.org>
// The License.txt file describes the conditions under which this software may be distributed.

// Adapted for BlitzMax by Bruce A Henderson, 2008.

// Supports Rem/End Rem blocks.

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <stdarg.h>

#include "Platform.h"

#include "PropSet.h"
#include "Accessor.h"
#include "StyleContext.h"
#include "KeyWords.h"
#include "Scintilla.h"
#include "SciLexer.h"

#ifdef SCI_NAMESPACE
using namespace Scintilla;
#endif

// for rem block
#define SCE_B_COMMENTREM 19

/* Bits:
 * 1  - whitespace
 * 2  - operator
 * 4  - identifier
 * 8  - decimal digit
 * 16 - hex digit
 * 32 - bin digit
 */
static int character_classification[128] =
{
    0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  1,  0,  0,  1,  0,  0,
    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    1,  2,  0,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  10, 2,
    60, 60, 28, 28, 28, 28, 28, 28, 28, 28, 2,  2,  2,  2,  2,  2,
    2,  20, 20, 20, 20, 20, 20, 4,  4,  4,  4,  4,  4,  4,  4,  4,
    4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  2,  2,  2,  2,  4,
    2,  20, 20, 20, 20, 20, 20, 4,  4,  4,  4,  4,  4,  4,  4,  4,
    4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  2,  2,  2,  2,  0
};

static bool IsSpace(int c) {
	return c < 128 && (character_classification[c] & 1);
}

static bool IsOperator(int c) {
	return c < 128 && (character_classification[c] & 2);
}

static bool IsIdentifier(int c) {
	return c < 128 && (character_classification[c] & 4);
}

static bool IsDigit(int c) {
	return c < 128 && (character_classification[c] & 8);
}

static bool IsHexDigit(int c) {
	return c < 128 && (character_classification[c] & 16);
}

static bool IsBinDigit(int c) {
	return c < 128 && (character_classification[c] & 32);
}

static int LowerCase(int c)
{
	if (c >= 'A' && c <= 'Z')
		return 'a' + c - 'A';
	return c;
}

static bool CheckBlitzEndRem(char const *token) {
	const char * k;
	const char * n;
	int i = 0;

	// endrem
	if (strlen(token) == 6) {
		k = token;
		n = "endrem";
		while (i++ < 6) {
			if (*k++ != *n++) return false;
		}
		return true;
	}
	
	// end rem
	if (strlen(token) == 7) {
		k = token;
		n = "end rem";
		while (i++ < 7) {
			if (*k++ != *n++) return false;
		}
		return true;
	}
	return false;
}

static void ColouriseBasicDoc(unsigned int startPos, int length, int initStyle,
                           WordList *keywordlists[], Accessor &styler, char comment_char) {
	bool wasfirst = true, isfirst = true; // true if first token in a line
	int endPos = startPos + length;
	char word[256];
	int wordlen = 0;
	styler.StartAt(startPos);

	StyleContext sc(startPos, length, initStyle, styler);

	// Can't use sc.More() here else we miss the last character
	for (; ; sc.Forward()) {
		if (sc.state == SCE_B_IDENTIFIER) {
			if (!IsIdentifier(sc.ch)) {
				// Labels
				if (wasfirst && sc.Match(':')) {
					sc.ChangeState(SCE_B_LABEL);
					sc.ForwardSetState(SCE_B_DEFAULT);
				} else {
					char s[100];
					int kstates[4] = {
						SCE_B_KEYWORD,
						SCE_B_KEYWORD2,
						SCE_B_KEYWORD3,
						SCE_B_KEYWORD4,
					};
					sc.GetCurrentLowered(s, sizeof(s));
					// special case for Rem blocks
    				if (strcmp(s, "rem") == 0) {
	   				    sc.ChangeState(SCE_B_COMMENTREM);
                    } else {
                        for (int i = 0; i < 4; i++) {
                            if (keywordlists[i]->InList(s)) {
                                sc.ChangeState(kstates[i]);
						break;
                            }
                        }
                        // Types, must set them as operator else they will be
                        // matched as number/constant
                        if (sc.Match('.') || sc.Match('$') || sc.Match('%') ||
                            sc.Match('#')) {
                            sc.SetState(SCE_B_OPERATOR);
                        } else {
                            sc.SetState(SCE_B_DEFAULT);
                        }
					}
				}
			}
		} else if (sc.state == SCE_B_COMMENTREM) {
		  // check if this line has endrem or end rem... indicating finish of rem block
		  if (sc.atLineStart) {
			bool go;
			wordlen = 0;
			for (int i = sc.currentPos; i < endPos; i++) {
				int c = styler.SafeGetCharAt(i);

				if (wordlen) { // are we scanning a token already?
					word[wordlen] = static_cast<char>(LowerCase(c));
					if (!IsIdentifier(c)) { // done with token
						if (wordlen > 8) {
							break;
						}
						word[wordlen] = '\0';
						go = CheckBlitzEndRem(word);
						if (!go) {
						    // skip linebreaks..
						    if (c == '\n' || c == '\r') {
						      wordlen = 0;
						      continue;
						    }
							// Treat any whitespace as single blank, for
							// things like "End   Function".
							if (IsSpace(c) && IsIdentifier(word[wordlen - 1])) {
								word[wordlen] = ' ';
								if (wordlen < 255)
									wordlen++;
							}
							else {  // done with this line
								break;
							}
						} else {
							sc.Forward(i - sc.currentPos);
							sc.SetState(SCE_B_DEFAULT);
							break;
						}
					} else if (wordlen < 255) {
						wordlen++;
					}
				} else { // start scanning at first non-whitespace character
					if (!IsSpace(c)) {
						if (IsIdentifier(c)) {
							word[0] = static_cast<char>(LowerCase(c));
							wordlen = 1;
						} else // done with this line
							break;
					}
				}
			}
		  }
		} else if (sc.state == SCE_B_OPERATOR) {
			if (!IsOperator(sc.ch) || sc.Match('#'))
				sc.SetState(SCE_B_DEFAULT);
		} else if (sc.state == SCE_B_LABEL) {
			if (!IsIdentifier(sc.ch))
				sc.SetState(SCE_B_DEFAULT);
		} else if (sc.state == SCE_B_CONSTANT) {
			if (!IsIdentifier(sc.ch))
				sc.SetState(SCE_B_DEFAULT);
		} else if (sc.state == SCE_B_NUMBER) {
			if (!IsDigit(sc.ch))
				sc.SetState(SCE_B_DEFAULT);
		} else if (sc.state == SCE_B_HEXNUMBER) {
			if (!IsHexDigit(sc.ch))
				sc.SetState(SCE_B_DEFAULT);
		} else if (sc.state == SCE_B_BINNUMBER) {
			if (!IsBinDigit(sc.ch))
				sc.SetState(SCE_B_DEFAULT);
		} else if (sc.state == SCE_B_STRING) {
			if (sc.ch == '"') {
				sc.ForwardSetState(SCE_B_DEFAULT);
			}
			if (sc.atLineEnd) {
				sc.ChangeState(SCE_B_ERROR);
				sc.SetState(SCE_B_DEFAULT);
			}
		} else if (sc.state == SCE_B_COMMENT || sc.state == SCE_B_PREPROCESSOR) {
			if (sc.atLineEnd) {
				sc.SetState(SCE_B_DEFAULT);
			}
		}

		if (sc.atLineStart)
			isfirst = true;

		if (sc.state == SCE_B_DEFAULT || sc.state == SCE_B_ERROR) {
			if (isfirst && sc.Match('.')) {
				sc.SetState(SCE_B_LABEL);
			} else if (isfirst && sc.Match('#')) {
				wasfirst = isfirst;
				sc.SetState(SCE_B_IDENTIFIER);
			} else if (sc.Match(comment_char)) {
				// Hack to make deprecated QBASIC '$Include show
				// up in freebasic with SCE_B_PREPROCESSOR.
				if (comment_char == '\'' && sc.Match(comment_char, '$'))
					sc.SetState(SCE_B_PREPROCESSOR);
				else
					sc.SetState(SCE_B_COMMENT);
			} else if (sc.Match('"')) {
				sc.SetState(SCE_B_STRING);
			} else if (IsDigit(sc.ch)) {
				sc.SetState(SCE_B_NUMBER);
			} else if (sc.Match('$')) {
				sc.SetState(SCE_B_HEXNUMBER);
			} else if (sc.Match('%')) {
				sc.SetState(SCE_B_BINNUMBER);
			} else if (sc.Match('#')) {
				sc.SetState(SCE_B_CONSTANT);
			} else if (IsOperator(sc.ch)) {
				sc.SetState(SCE_B_OPERATOR);
			} else if (IsIdentifier(sc.ch)) {
				wasfirst = isfirst;
				sc.SetState(SCE_B_IDENTIFIER);
			} else if (!IsSpace(sc.ch)) {
				sc.SetState(SCE_B_ERROR);
			}
		}

		if (!IsSpace(sc.ch))
			isfirst = false;

		if (!sc.More())
			break;
	}
	sc.Complete();
}

static int CheckBlitzFoldPoint(char const *token, int &level) {
	if (!strcmp(token, "function") ||
		!strcmp(token, "type") ||
		!strcmp(token, "method")) {
		level |= SC_FOLDLEVELHEADERFLAG;
		return 1;
	}
	if (!strcmp(token, "end function") ||
        !strcmp(token, "endfunction") ||
        !strcmp(token, "end type") ||
	 	!strcmp(token, "endtype") ||
		!strcmp(token, "end method") ||
        	!strcmp(token, "endmethod")) {
		return -1;
	}
	return 0;
}

static void FoldBasicDoc(unsigned int startPos, int length,
	Accessor &styler, int (*CheckFoldPoint)(char const *, int &)) {
	int line = styler.GetLine(startPos);
	int level = styler.LevelAt(line);
	int go = 0, done = 0;
	int endPos = startPos + length;
	char word[256];
	int wordlen = 0;
	int i;
        bool foldCompact = styler.GetPropertyInt("fold.compact", 1) != 0;
	// Scan for tokens at the start of the line (they may include
	// whitespace, for tokens like "End Function"
	for (i = startPos; i < endPos; i++) {
		int c = styler.SafeGetCharAt(i);
		if (!done && !go) {
			if (wordlen) { // are we scanning a token already?
				word[wordlen] = static_cast<char>(LowerCase(c));
				if (!IsIdentifier(c)) { // done with token
					word[wordlen] = '\0';
					go = CheckFoldPoint(word, level);
					if (!go) {
						// Treat any whitespace as single blank, for
						// things like "End   Function".
						if (IsSpace(c) && IsIdentifier(word[wordlen - 1])) {
							word[wordlen] = ' ';
							if (wordlen < 255)
								wordlen++;
						}
						else // done with this line
							done = 1;
					}
				} else if (wordlen < 255) {
					wordlen++;
				}
			} else { // start scanning at first non-whitespace character
				if (!IsSpace(c)) {
					if (IsIdentifier(c)) {
						word[0] = static_cast<char>(LowerCase(c));
						wordlen = 1;
					} else // done with this line
						done = 1;
				}
			}
		}
		if (c == '\n') { // line end
			if (!done && wordlen == 0 && foldCompact) // line was only space
				level |= SC_FOLDLEVELWHITEFLAG;
			if (level != styler.LevelAt(line))
				styler.SetLevel(line, level);
			level += go;
			line++;
			// reset state
			wordlen = 0;
			level &= ~SC_FOLDLEVELHEADERFLAG;
			level &= ~SC_FOLDLEVELWHITEFLAG;
			go = 0;
			done = 0;
		}
	}
}

static void ColouriseBlitzMaxDoc(unsigned int startPos, int length, int initStyle,
                           WordList *keywordlists[], Accessor &styler) {
	ColouriseBasicDoc(startPos, length, initStyle, keywordlists, styler, '\'');
}

static void FoldBlitzMaxDoc(unsigned int startPos, int length, int,
	WordList *[], Accessor &styler) {
	FoldBasicDoc(startPos, length, styler, CheckBlitzFoldPoint);
}

static const char * const blitzmaxWordListDesc[] = {
	"BlitzMax Keywords",
	"user1",
	"user2",
	"user3",
	"BlitzMax Cased-Keywords",
	"user1 cased",
	"user2 cased",
	"user3 cased",
	0
};


LexerModule lmBlitzMax(SCLEX_BLITZBASIC, ColouriseBlitzMaxDoc, "blitzmax",
	FoldBlitzMaxDoc, blitzmaxWordListDesc);

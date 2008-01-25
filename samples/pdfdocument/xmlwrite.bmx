SuperStrict

Import wx.wxPdfDocument

Function xmlwrite()
	
	Local  xmlString1:String = "<p align=~qjustify~q>This example shows text <b>styling</b> with <i>simple</i> XML. " + ..
						"H<sub>2</sub>SO<sub>4</sub> is an acid. Nesting of super- or subscripting is possible: x<sup>i<sup>2</sup></sup> + y<sub>k<sub>3</sub></sub>. " + ..
						"Now follows a <i>rather</i> long text, showing whether the justification algorithm <b>really</b> works. At least one <b>additional</b> line should be printed, further <b><font color=~qred~q>demonstrating</font></b> the algorithm." + ..
						"<br/><u>Underlined <b>and </b> <s>striked through</s></u> or <o>overlined</o></p><img src=~q../media/pdfdocument/wxpdfdoc.png~q width=~q160~q height=~q120~q align=~qcenter~q/>"
	Local xmlString2:String = "<h1>Header 1 (left)</h1><h2 align=~qright~q>Header 2 (right)</h2><h3 align=~qcenter~q>Header 3 (centered)</h3><h4 align=~qjustify~q>Header 4 (justified)</h4><h5>Header 5</h5><h6>Header 6</h6>"
	Local xmlString3:String = "Let's start an enumeration with roman numerals at offset 100:<ol type=~qi~q start=~q100~q><li>Anton</li><li>Berta</li><li>Caesar</li></ol>Who would be next?" + ..
						"<p align=~qright~q>This section should be right aligned.<br/>Do you want to go to the <a href=~qhttp://www.wxwidgets.org~q>wxWidgets website</a>?</p>"
	Local xmlString4:String = "<h1>Nested tables example</h1><br/><table border=~q1~q><colgroup><col width=~q40~q span=~q4~q /></colgroup><tbody><tr height=~q12~q><td bgcolor=~q#cccccc~q>Cell 1,1</td><td colspan=~q2~q align=~qcenter~q valign=~qmiddle~q>Cell 1,2-1,3</td><td>Cell 1,4</td></tr><tr><td>Cell 2,1</td><td>Cell 2,2</td><td>Cell 2,3</td><td>Cell 2,4</td></tr><tr><td>Cell 3,1</td><td>Cell 3,2</td><td colspan=~q2~q rowspan=~q2~q align=~qcenter~q>" + ..
						"<table border=~q1~q><colgroup><col width=~q19~q span=~q4~q /></colgroup><tbody odd=~q#cceeff~q even=~q#ccffee~q><tr><td bgcolor=~q#cccccc~q>Cell 1,1</td><td colspan=~q2~q>Cell 1,2-1,3</td><td>Cell 1,4</td></tr><tr><td>Cell 2,1</td><td>Cell 2,2</td><td>Cell 2,3</td><td>Cell 2,4</td></tr><tr><td>Cell 3,1</td><td>Cell 3,2</td><td colspan=~q2~q rowspan=~q2~q>Cell 3,3-4.4</td></tr><tr><td>Cell 4,1</td><td>Cell 4,2</td></tr></tbody></table>" + ..
						"</td></tr><tr><td>Cell 4,1</td><td>Cell 4,2</td></tr></tbody></table>"
	Local xmlString5:String = "<h1>Table with row and column spans</h1><br/><table border=~q1~q align=~qcenter~q>~n" + ..
						"<colgroup><col width=~q50~q/><col width=~q20~q/><col width=~q30~q/><col width=~q20~q span=~q3~q /></colgroup>~n" + ..
						"<tbody><tr><td rowspan=~q2~q valign=~qmiddle~q border=~q0~q>rowspan=2, valign=middle</td><td>Normal</td><td>Normal</td><td>Normal</td><td colspan=~q2~q rowspan=~q2~q valign=~qbottom~q bgcolor=~q#FF00FF~q>colspan=2<br/>rowspan=2<br/>valign=bottom</td></tr>~n" + ..
						"<tr><td height=~q15~q>Normal</td><td rowspan=~q2~q align=~qright~q bgcolor=~q#aaaaaa~q border=~q0~q>rowspan=2</td><td border=~q0~q>border=0</td></tr>~n" + ..
						"<tr><td>Normal</td><td>Normal</td><td>Normal</td><td rowspan=~q3~q valign=~qtop~q bgcolor=~q#CC3366~q>rowspan=3</td><td>Normal</td></tr>~n" + ..
						"<tr bgcolor=~q#cccccc~q><td>Normal</td><td colspan=~q3~q align=~qcenter~q>align center, colspan=3</td><td>Normal</td></tr>~n" + ..
						"<tr height=~q20~q><td align=~qright~q valign=~qbottom~q>align=right<br/>valign=bottom</td><td>Normal</td><td>&#160;</td><td>Normal</td><td>height=20</td></tr>~n" + ..
						"</tbody></table>"
	Local xmlString6:String = "<h1>Table with more rows than fit on a page</h1><br/><table border=~q1~q><colgroup><col width=~q20~q/></colgroup>" + ..
						"<thead><tr bgcolor=~q#999999~q><td><b>Headline</b></td></tr></thead>" + ..
						"<tbody odd=~q#ffffff~q even=~q#dddddd~q>" + ..
						"<tr><td>This is a table cell with some text. This is a table cell with some text. This is a table cell with some text.</td></tr>" + ..
						"<tr><td>This is a table cell with some text. This is a table cell with some text. This is a table cell with some text.</td></tr>" + ..
						"<tr><td>This is a table cell with some text. This is a table cell with some text. This is a table cell with some text.</td></tr>" + ..
						"<tr><td>This is a table cell with some text. This is a table cell with some text. This is a table cell with some text.</td></tr>" + ..
						"<tr><td>This is a table cell with some text. This is a table cell with some text. This is a table cell with some text.</td></tr>" + ..
						"<tr><td>This is a table cell with some text. This is a table cell with some text. This is a table cell with some text.</td></tr>" + ..
						"<tr><td>This is a table cell with some text. This is a table cell with some text. This is a table cell with some text.</td></tr>" + ..
						"<tr><td>This is a table cell with some text. This is a table cell with some text. This is a table cell with some text.</td></tr>" + ..
						"<tr><td>This is a table cell with some text. This is a table cell with some text. This is a table cell with some text.</td></tr>" + ..
						"</tbody></table>"
	Local xmlString7:String = "<table border=~q1~q><tbody><tr bgcolor=~q#ffff00~q><td><font face=~qCourier~q>" + ..
						"This is a very simple table with text in font face Courier." + ..
						"<code>    // 4 leading spaces~n    <b>if</b> (condition)~n      x++;~n    <b>else</b>&#160;~n      x--;</code>" + ..
						"<br/></font></td></tr></tbody></table>" + ..
						"<code>    // 4 leading spaces~n    <b>if</b> (condition)~n      x++;~n    <b>else</b>&#160;~n      x--;</code>"
	
	Local pdf:wxPdfDocument = New wxPdfDocument.Create()
	pdf.AddPage()
	pdf.SetFont("Arial", "", 10)
	pdf.SetRightMargin(50)
	pdf.WriteXml("<a name=~qtop~q>Top of first page</a><br/>")
	pdf.WriteXml("<a href=~q#bottom~q>Jump to bottom of last page</a><br/>")
	pdf.WriteXml(xmlString1)
	pdf.Ln()
	pdf.WriteXml("<a name=~qsecond~q>Second anchor</a><br/>")
	pdf.WriteXml(xmlString2)
	pdf.WriteXml("<a name=~qthird~q>Third anchor</a><br/>")
	pdf.WriteXml(xmlString3)
	pdf.AddPage()
	pdf.SetLeftMargin(20)
	pdf.SetRightMargin(20)
	pdf.SetFont("Arial", "", 10)
	pdf.WriteXml("<a name=~qfourth~q>Fourth anchor</a><br/>")
	pdf.WriteXml(xmlString4)
	pdf.Ln(20)
	pdf.WriteXml(xmlString5)
	pdf.Ln(20)
	pdf.WriteXml(xmlString6)
	pdf.AddPage()
	pdf.WriteXml(xmlString7)
	pdf.WriteXml("<a name=~qbottom~q>Bottom anchor</a><br/>")
	pdf.WriteXml("<a href=~q#top~q>Jump to top of first page</a><br/>")
	pdf.WriteXml("<a href=~q#second~q>Jump to second anchor</a><br/>")
	pdf.WriteXml("<a href=~q#third~q>Jump to third anchor</a><br/>")
	
	pdf.SaveAsFile("xmlwrite.pdf")
End Function

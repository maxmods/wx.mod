
#include <glib.h>
#include <stdio.h>

typedef struct {
	GSource source;
	GPollFD fd;
} MaxEventSource;

static gboolean bmx_wxmg_event_source_prepare(GSource * base, int * timeout) {
	*timeout = -1;
	return FALSE;
}

static gboolean bmx_wxmg_event_source_check(GSource * base) {
	MaxEventSource *source = (MaxEventSource*)base;
	return source->fd.revents;
}

static gboolean bmx_wxmg_event_source_dispatch(GSource * base, GSourceFunc callback, void * data) {
	MaxEventSource * source = (MaxEventSource*)base;
	bbSystemFlushAsyncOps();
	return TRUE;
}

static GSourceFuncs bmx_wxmg_event_source_funcs =
{
	bmx_wxmg_event_source_prepare,
	bmx_wxmg_event_source_check,
	bmx_wxmg_event_source_dispatch,
	NULL
};

GSource * bmx_wxmg_event_source_new(int fd) {
	MaxEventSource * source = (MaxEventSource *) g_source_new(&bmx_wxmg_event_source_funcs, sizeof(MaxEventSource));
	source->fd.fd = fd;
	source->fd.events = G_IO_IN | G_IO_HUP | G_IO_ERR;
	g_source_add_poll(&source->source, &source->fd);
	
	g_source_attach(&source->source, g_main_context_default());
	
	return &source->source;
}

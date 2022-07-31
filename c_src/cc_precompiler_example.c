#include <stdio.h>
#include <erl_nif.h>

static ERL_NIF_TERM hello_world(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_string(env, "hello world", ERL_NIF_LATIN1);
}

static ErlNifFunc nif_funcs[] =
{
    {"hello_world", 0, hello_world, 0}
};

ERL_NIF_INIT(cc_precompiler_example, nif_funcs, NULL, NULL, NULL, NULL);

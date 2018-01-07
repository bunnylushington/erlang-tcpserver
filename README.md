tcpserver
=====

Simple Erlang TCP server.  This code is simply
https://github.com/kevinlynx/erlang-tcpserver repackaged to work well
with rebar3 (with a few of the names changed).  Many thanks to the
original developer @kevinlynx.

Usage
-----

Add something like this to rebar.config:

    {deps, [{tcpserver, {git, "git://github.com/bunnylushington/tcpserver", 
                        {branch, master}}}]}
                        
                        

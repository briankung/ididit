kill `cat tmp/pids/server.pid`
if [[ "$?" -eq "0" ]]; then
    echo "Server stopped";
else
    echo "Something went wrong!";
fi 


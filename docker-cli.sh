#!/bin/sh

 displayUsage()
{
    echo "---------------------------------------------------------------------------"
    echo "Build container: "
    echo "  docker-cli build"
    echo ""
    echo "Start container: "
    echo "  docker-cli start"
    echo ""
    echo "Stop container: "
    echo "  docker-cli stop"
    echo ""
    echo "Connect to server container: "
    echo "  docker-cli exec"
    echo "---------------------------------------------------------------------------"
}
 start()
{	
    docker-compose -f docker-compose.yml up -d 
}
 stop()
{
    docker-compose -f docker-compose.yml down
}
 build()
{
    docker-compose -f docker-compose.yml build
}
 containerExec()
{
    docker-compose -f docker-compose.yml exec php bash
}
 case "$1" in
    build)
        build
    ;;
    start)
        start
    ;;
    stop)
        stop
    ;;
    exec)
        containerExec 
    ;;
    *) displayUsage
    ;;
esac

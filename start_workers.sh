#!/bin/sh
#
# Author: Aniruddha Gokhale
# Vanderbilt University
# EECS 4287-5287 Cloud Computing
# Created: Nov 2017
#
# Purpose: Script to start the map and reduce workers
#
# Depending on your need, change the replica numbers accordingly
# Here we disallow spawning any of our workers on the master node. Swarm
# will load balance them appropriately on other nodes of your swarm
#
# Notice also that we supply the floating IP of the master host which will then
# map it to the right container port.
#
# Change the floating IP to yours. Change host names to yours.
#
# The restart condition of "none" prevents the manager from restarting the
# workers after they are done.
docker service create --restart-condition "none" --replicas 100 --name MR_Map --constraint 'node.hostname != team15-docker-master' -t --network MR_Network 129.114.33.132:5000/mr_map python /root/mr_mapworker.py 129.114.33.132 5556
docker service create --restart-condition "none" --replicas 10 --name MR_Reduce --constraint 'node.hostname != team15-docker-master' -t --network MR_Network 129.114.33.132:5000/mr_reduce python /root/mr_reduceworker.py 129.114.33.132 5556

#! /bin/bash
# Build quantum graph for gathering memory usage for given collection
# set.
# Call: ./make_memory_graph.sh repo output_file list_of_collections
# repo - butler.yaml file with path like '/sdf/group/rubin/repo/dc2/butler.yaml'
# output_file - the name of quantum graph file to be created, should have gqraph
#               extension
# collections_file - a text file containing a list of space separated           
#                    collections
#like:    
#           2.2i/runs/test-med-1/w_2022_46/DM-36954/20221111T202908Z
#	    2.2i/runs/test-med-1/w_2022_46/DM-36954/20221113T192820Z 
repo=$1
outfile=$2
collections_file=$3
collections=`cat $collections_file`
echo $collections
echo build-gather-resource-usage-qg $repo $outfile $collections
build-gather-resource-usage-qg $repo $outfile $collections

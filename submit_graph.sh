#! /bin/bash
# Submit quantum graph with bps
# 
# Call: ./submit_graph.sh stack graph repo output_dir list_of_collections
# stack - LSST stack version like 'w_2022_50'
# grapf - a file with .qgraph extention created in make_memory_graph.sh command
# repo - base directory of the butler repo like '/sdf/group/rubin/repo/dc2'
# output_dir - the name a directory where results will be written.          
# Like  ${repo}/'u/kuropatk/w_2022_50/'
#       
# collections_file - a text file containing a list of space separated           #                    collections
#like:    
#           2.2i/runs/test-med-1/w_2022_46/DM-36954/20221111T202908Z
#	    2.2i/runs/test-med-1/w_2022_46/DM-36954/20221113T192820Z 
# example: ./submit_graph.sh w_2023_05 ./memoryGrapf.qgraph  /sdf/group/rubin/repo/dc2 u/kuropatk/test/ ./collections_file.txt
stack=$1
graph=$2
repo=$3
output_dir=$4
collections_file=$5
echo  $stack $graph $repo $outdir $collection_file
# First copy butler yaml file and edit it to insert stack version
cp ${CTRL_BPS_PANDA_DIR}/config/bps_usdf.yaml bps_usdf.yaml
match='# PanDA does the scheduling based on memory request'
insert='LSST_VERSION: '$stack
file='./bps_usdf.yaml'

sed -i "s/$match/$match\n$insert/" $file

#Now create list of collections
collections=`cat $collections_file`
coll_list1=''
for collection in $collections;
  do
   coll_list1+=$collection
   coll_list1+=','
  done
  echo $coll_list1
# get rid of the last comma
coll_list=${coll_list1::${#coll_list1}-1}
echo $coll_list
# Now create output dir if not exists
mkdir -p $output_dir
chmod ugo+rw $output_dir
#Finally submit the graph to panda with pbs
echo bps submit -g $graph ./bps_usdf.yaml -b $repo -i $coll_list -o $output_dir
bps submit -g $graph ./bps_usdf.yaml -b $repo -i $coll_list -o $output_dir

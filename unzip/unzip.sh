# sh common_utils/unzip/unzip.sh zip/ms-swift.zip ms-swift

zip_file_path=$1
tgt_folder=$2
tmp_folder=tmp_unpack
unzip $zip_file_path -d $tmp_folder
mv $tmp_folder/* $tgt_folder && rmdir $tmp_folder
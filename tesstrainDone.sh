mkdir -p train
rm -rf train/*

#Update the value of fontlist according to training fonts name
#Update the value of lang according to training language
sh tesstrain.sh \
  --fonts_dir fonts\
  --fontlist 'Impact Condensed' \
  --lang eng  \
  --linedata_only   \
  --langdata_dir langdata_lstm \
  --tessdata_dir tessdata \
  --save_box_tiff \
  --maxpages 10\
  --output_dir train 
  
  mkdir -p output
  rm -rf output/*
  
  #Update eng.traineddata and eng.lstm according to training language to lang.traineddata and lang.lstm
  combine_tessdata -e tessdata/eng.traineddata train/eng.lstm
  
  #Update eng.lstm/eng.traineddata/eng.training_files.txt according to training language
  #Update output/Impact according to training font name
  lstmtraining \
  --continue_from train/eng.lstm \
  --model_output output/Impact \
  --traineddata tessdata/eng.traineddata \
  --train_listfile train/eng.training_files.txt \
  --debug_interval -1\
  --max_iterations 500
  
  #Update eng.traineddata according to training language
  #Update impact_checkpoint and Impact.traineddata according to training font name
  lstmtraining --stop_training \
  --continue_from output/impact_checkpoint \
  --traineddata tessdata/eng.traineddata \
  --model_output output/Impact.traineddata
# tesstrainsh-win
Train Tesseract LSTM with tesstrain.sh on Windows 
# About tesstrainsh-win
The file structure in tesstrainsh-win:
![image](https://github.com/livezingy/tesstrainsh-win/blob/master/file_structure.png)
# Recommendations for choosing a training method
![image](https://github.com/livezingy/tesstrainsh-win/blob/master/tesstrainChoose.png)
# Requirements
## tesseract
You will need a recent version (>= 4.0.0beta1) of tesseract built with the training tools and matching leptonica bindings. 

Build instructions and more can be found in the [Tesseract project wiki](https://github.com/tesseract-ocr/tesseract/wiki).

## Git for Windows
Install the Git for Windows,and add the path where Git / bin is located to the Path path of the environment variable.

# How to Use tesstrainsh-win
1. Copy the font file to be trained to the tesstrain / fonts path. tesstrain.sh supports training multiple font files at the same time. e. g., There is a font file in tesstrain / fonts / Impact.ttf.

2. Copy the langdata_lstm files of the font to be trained to tesstrainsh-win / langdata_lstm. e. g., all files downloaded from the [langdata_lstm/eng](https://github.com/tesseract-ocr/langdata_lstm/tree/master/eng) place in the tesstrainsh-win / langdata_lstm / eng. If you need to train Simplified Chinese, create a new chi_sim folder under the tesstrainsh-win / langdata_lstm path, download all files under [langdata_lstm/chi_sim](https://github.com/tesseract-ocr/langdata_lstm/tree/master/chi_sim)  and place them under the tesstrainsh-win / langdata_lstm / chi_sim path.

3. Copy the basic traineddata to be trained to the path tesstrainsh-win / tessdata. e. g.,  The path of the eng.traineddata is  tesstrainsh-win / tessdata / eng.traineddata. The .traineddata download from [tessdata_best](https://github.com/tesseract-ocr/tessdata_best).

4. Copy lstm.train to the path tesstrainsh-win/tessdata/configs. The file is under the tesseract installation path.(e.g., C: / Program Files/tesseract/tessdata/configs). I have prepared the file in tesstrainsh-win. But my Tesseract version is 4.1, if your Tesseract version is different,it is recommended that the file version also be consistent with your Tesseract version. Find the file from the tesseract installation path and copy them to tesstrainsh-win / tessdata / configs to overwrite the existing files.

5. The tesstrain.sh, tesstrain_utils.sh and language-specific.sh under the tesstrainsh-win project are copied from the Tesseract4.1 source code (Tesseract / src / training). If you are using other versions of training tools, it is recommended that these three file versions also be consistent. Find these three files in the source code path and copy to the path tesstrainsh-win to overwrite the existing files.

6. Run the command prompt as an administrator, Go to the tesstrainsh-win directory, e. g.:
```
cd %USERPROFILE%/tesstrainsh-win
```

7. run sh tesstrainDone.sh
```
sh tesstrainDone.sh
```
When running this command, the following error may occur:
```
Reducing Trie to SquishedDawg
Error during conversion of wordlists to DAWGs!!
ERROR: Program Program failed. Abort. 
```
It because that the LF in Unix corresponding to the CRLF in Windows.
Please correct all the CRLF in the files in the path of tesstrainsh-win/langdata_lstm/eng to LF.

If the command is executed successfully， these tips will be showed:
```
Finished! Error rate = 0.864
Loaded file output/impact_checkpoint, unpacking... 
```

8. During the training process, two folders will be created under the tesstrainsh-win path：train and output.

train: The intermediate files generated during the training process are in this folder, for example, .box / .tif / .lstmf and other files are in this folder.

output: The staged checkpoints generated during the training process and the Impact.traineddata will be placed in this folder.

9. if you want to evaluate training results, you could run the command:
```
sh eval.sh
```
The code to evaluate the eng.traineddata:
```
lstmeval \
--model train/eng.lstm \
--traineddata tessdata/eng.traineddata \
--eval_listfile train/eng.training_files.txt 
```
The code to evaluate the new trained traineddata, e.g.: Impact.traineddata:
```	
lstmeval \
--model output/Impact_checkpoint \
--traineddata tessdata/eng.traineddata \
--eval_listfile train/eng.training_files.txt 
```

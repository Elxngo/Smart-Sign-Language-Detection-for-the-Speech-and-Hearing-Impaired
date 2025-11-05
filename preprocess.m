clc; clear; close all;

filename = 'sign_mnist_train.csv';
dataTable = readtable(filename);

labels = categorical(dataTable{:,1});    % Labels 0-25
pixels = dataTable{:,2:end};            % 784 pixel values

outputFolder = 'ProcessedSignImages';
if isfolder(outputFolder), rmdir(outputFolder, 's'); end
mkdir(outputFolder);

for i = 1:height(dataTable)
    img = reshape(pixels(i,:), [28, 28]);
    img = imresize(img, [224 224]);  % For GoogLeNet or MobileNet
    img = repmat(img, [1 1 3]);      % Convert to RGB
    
    labelChar = char(65 + double(labels(i)));
    folderPath = fullfile(outputFolder, labelChar);
    if ~exist(folderPath, 'dir'), mkdir(folderPath); end
    
    filenameOut = fullfile(folderPath, sprintf('%d.png', i));
    imwrite(uint8(img), filenameOut);
end

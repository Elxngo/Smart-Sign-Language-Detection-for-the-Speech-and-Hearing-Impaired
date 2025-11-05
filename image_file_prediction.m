function image_file_prediction(aslNet, inputSize)
    [file, path] = uigetfile({'*.jpg;*.png;*.jpeg'}, 'Select an Image File');
    if isequal(file, 0)
        disp('No image selected.');
        return;
    end

    img = imread(fullfile(path, file));
    img = imresize(img, inputSize(1:2));

    if size(img, 3) == 1
        img = cat(3, img, img, img);
    end

    prediction = classify(aslNet, img);

    figure('Name', 'Image Prediction');
    imshow(img);
    title(['Predicted Sign: ', char(prediction)], 'FontSize', 18);
    disp(['✅ Predicted Sign: ', char(prediction)]);
end

function numConverted = CSV_Converter()
% Converts as many .csv files as selected into .mat files and daves them to
% the same path with the same file name.
% Use for converting CSV files produced by ECTLogger to .mat files for
% analysis and use in R_DECO.
% Assumes the csv file has 2 columns of data.


    % Prompt to select multiple CSV files
    [fileNames, filePath] = uigetfile('*.csv', 'Select CSV files', 'MultiSelect', 'on');
    
    if isequal(fileNames,0)
        % User clicked Cancel
        disp('No files selected');
        numConverted = 0;
        return;
    end
    
    % Check if a single file was selected (returns a string instead of a cell array)
    if ischar(fileNames)
        fileNames = {fileNames};
    end
    
    numFiles = length(fileNames);
    numConverted = 0;
    
    for i = 1:numFiles
        try
            % Read data from the CSV file
            data = csvread(fullfile(filePath, fileNames{i}));
            
            % Extract the file name without the extension
            [~, fileNameNoExt, ~] = fileparts(fileNames{i});
            
            % Create the MAT file name
            matFileName = fullfile(filePath, [fileNameNoExt, '.mat']);
            
            % Save the data into a MAT file
            save(matFileName, 'data');
            
            numConverted = numConverted + 1;
        catch
            fprintf('Error converting file %s.\n', fileNames{i});
        end
    end
    
    fprintf('%d out of %d files converted successfully.\n', numConverted, numFiles);
end

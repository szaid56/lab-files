function task_3(varargin)
    
    pathofimage = 'spiral.jpg';
    
    if nargin > 0
        pathofimage = varargin{1};
    end
    originalimage = imread(pathofimage);
    compression_values = [2, 4, 8, 16];
    
    for i = 1:length(compression_values)
        compression_factor = compression_values(i);
        compressedimage = zeros(size(originalimage), 'uint8');
        for channel = 1:3
            originalchannel = originalimage(:, :, channel);
            Mappedvalues = (0:(compression_factor - 1)) * 256 / compression_factor + 256 / (2 * compression_factor);
            for k = 1:compression_factor
                mask = originalchannel >= (k - 1) * (256 / compression_factor) & originalchannel <= k * (256 / compression_factor);
                compressedimage(:, :, channel) = compressedimage(:, :, channel) + uint8(mask) * Mappedvalues(k);
            end
        end
       
        figure;
        subplot(1, 2, 1), imshow(originalimage), title('Original Image');
        subplot(1, 2, 2), imshow(uint8(compressedimage)), title(['Compressed Image (N=' num2str(compression_factor) ')']);
    end
end

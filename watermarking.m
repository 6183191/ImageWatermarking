function image = watermarking(original, watermark)
    image = original;
    [rows, cols, ~] = size(original);
    length = rows;
    if rows > cols
        length = cols;
    end
    
    waterimage_size = length * 0.1;
    watermark = imresize_nn(watermark, waterimage_size, waterimage_size);    
    %watermark = imresize(watermark, [waterimage_size, waterimage_size]);    
    [w_rows, w_cols,~]=size(watermark);
    
    alpha = 1; %0.5;
    Sz = [(rows - w_rows - 50) (cols - w_cols - 50)];
    at = 0.5;
    tmpWatermark=(1-at)*watermark + at.*image(Sz(1):Sz(1)+w_rows-1,Sz(2):Sz(2)+w_cols-1,:);

    image(Sz(1):Sz(1)+w_rows-1,Sz(2):Sz(2)+w_cols-1,:)=(1-alpha)*image(Sz(1):Sz(1)+w_rows-1,Sz(2):Sz(2)+w_cols-1,:) + alpha.*tmpWatermark;
end
function output = imresize_nn(image, nr, nc)
    row = size(image,1);
    col = size(image,2);

    ratio_r = nr/row;
    ratio_c = nc/col;

    ir = ceil([1:(row*ratio_r)]./(ratio_r));
    ic = ceil([1:(col*ratio_c)]./(ratio_c));

    tmp = image(:,:,1);
    r = tmp(ir,:);
    r = r(:,ic);

    tmp = image(:,:,2);
    g = tmp(ir,:);
    g = g(:,ic);

    tmp = image(:,:,3);
    b = tmp(ir,:);
    b = b(:,ic);

    output = zeros([size(r,1), size(r,2), 3]);
    output(:,:,1)=r;
    output(:,:,2)=g;
    output(:,:,3)=b;
    output = uint8(output);
end
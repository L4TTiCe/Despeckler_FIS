% Script to diplat the histogram of an Image

[fname, pthname]=uigetfile('*.jpg;*.png;*.tif;*.bmp','Select the Asset Image'); %select image 

[m, n] = size(img);
img = imread([pthname fname]);

figure
histogram(img)

limits = quantile(img(:), 3);
r1 = [];
r2 = [];
r3 = [];

tic
poolobj = parpool(6);
i_loop_var = m-1;
j_loop_var = n-1;

pctRunOnAll warning off

numIterations = i_loop_var;
ppm = ParforProgressbar(numIterations, 'showWorkerProgress', true);

parfor i = 1:i_loop_var
    for j = 1:j_loop_var
        val = img(i, j);
        if val <= limits(1)
            r1 = [r1, val]
        elseif val <= limits(2)
            r2 = [r2, val]
        else
            r3 = [r3, val]
        end
    end
    ppm.increment();
end

% Delete the progress handle when the parfor loop is done (otherwise the 
% timer that keeps updating the progress might not stop).
delete(ppm);
delete(poolobj)
toc
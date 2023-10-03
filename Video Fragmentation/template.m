clear all
format long
R=VideoReader ('visiontraffic.avi'); %creates object v to read video data from the file named filename
X_Data=Matrix_video(R,171,200);%Put the 30 frames in a matrix
[n,m]=size(X_Data);
X = double(X_Data);


%% implementare
p =  0.007;
lam = 0.0002;
eps = 0.1;

L2 = rand(n,m);
S1 = rand(n,m);
Y1 = rand(n,m);
LAM1 = rand(n,m); % multiplicator lagrangian

crit2 =10;
iter = 1;
Iter_max = 10000;
crit1 = 20;
residuu = [];
while crit1 ~= 1 && crit2 > eps && iter< Iter_max

[U,Sig,V] = svd( (X - S1 - LAM1/p ),0);

SIG_plus = Sig - eye(m)/p;  % ar putea fi si eye(n)

SIG_plus = proiectie(SIG_plus);

L2 = U* SIG_plus*V';

S2 = stfunction(X - L2 - LAM1/p , lam/p);

LAM2 = LAM1 + p*(L2+S2 - X);
crit2 = p*norm(S2 - S1);
S1 = S2;
LAM1 = LAM2;
residuu(iter) = norm(L2 + S2 - X,2);
crit1 = rank(L2);

iter = iter+1;
end


%% PRELUCRAREA DATELOR SI AFISARE
figure("Name",'Reziduu');
semilogy(residuu);

X1 = cast(L2,'uint8');
Z1 = cast(S2,'uint8');
W1 = cast(X,'uint8');

for (i = 1:2:m-1)
    figure(i+1);
    subplot(2,3,1);

    imshow(reshape(X1(:,i),360,640), 'InitialMagnification',200);
    title('Subplot 1: Background');

    subplot(2,3,2);

    imshow(reshape(Z1(:,i),360,640), 'InitialMagnification',200);
    title('Subplot 2: moving objects');

    subplot(2,3,3);

    imshow(reshape(W1(:,i),360,640) , 'InitialMagnification',200);
    title('Subplot 3: initial frame');

    subplot(2,3,4);

    imshow(reshape(X1(:,i+1),360,640), 'InitialMagnification',200);
    title('Subplot 4: Background');

    subplot(2,3,5);

    imshow(reshape(Z1(:,i+1),360,640), 'InitialMagnification',200);
    title('Subplot 5: moving objects');

    subplot(2,3,6);

    imshow(reshape(W1(:,i+1),360,640) , 'InitialMagnification',200);
    title('Subplot 6: initial frame');

end


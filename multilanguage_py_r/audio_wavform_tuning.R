install.packages("tuneR")
library(tuneR)

open_and_processing = function(filename)
{
  w = readWave(file = filename)
  vl = length(w@left)
  w2 = downsample(w, 2048)
  w2 = mono(w2)
  
  nw2 = normalize(w2, unit="8") #normalization to 8 bit
  #play(nw2)
  mfcc_nw2 = melfcc(nw2)
  
  par(mfrow = c(1,3))
  plot(nw2)
  plot(mfcc_nw2)
  plot(mfcc_nw2[ ,1])
  return(list("mfcc"= mfcc_nw2, "wav" = nw2))
}

fl = dir(patter = "wav")
mfcc_list_each_file = list()
i = 1
for(f in fl)
{
  mfcc_list_each_file[[i]] = open_and_processing(f)
  i = i+1
}

length(mfcc_list_each_file)

summary(mfcc_list_each_file[[2]])

mfcc_list_each_file

########################################################
## Train
########################################################
install.packages("rnn")
library(rnn)
packageVersion("rnn")
xx = mfcc_list_each_file[[1]]
xx = xx$mfcc
dim(xx)
xa1 = xx[,1]
xb1 = xx[,2]
xa1 = xa1[1:2000]
xb1 = xb1[1:2000]
ya = rep(1,2000)

xx = mfcc_list_each_file[[2]]
xx = xx$mfcc
dim(xx)
xa2 = xx[,1]
xb2 = xx[,2]
xa2 = xa2[1:2000]
xb2 = xb2[1:2000]
yb = rep(2,2000)

xx = mfcc_list_each_file[[3]]
xx = xx$mfcc
dim(xx)
xa3 = xx[,1]
xb3 = xx[,2]
xa3 = xa3[1:2000]
xb3 = xb3[1:2000]
yc = rep(3,2000)

xx = mfcc_list_each_file[[4]]
xx = xx$mfcc
dim(xx)
xa4 = xx[,1]
xb4 = xx[,2]
xa4 = xa4[1:2000]
xb4 = xb4[1:2000]
yd = rep(4,2000)

xx = mfcc_list_each_file[[5]]
xx = xx$mfcc
dim(xx)
xa5 = xx[,1]
xb5 = xx[,2]
xa5 = xa5[1:2000]
xb5 = xb5[1:2000]
ye = rep(5,2000)

xx = mfcc_list_each_file[[6]]
xx = xx$mfcc
dim(xx)
xa6 = xx[,1]
xb6 = xx[,2]
xa6 = xa6[1:2000]
xb6 = xb6[1:2000]
yf = rep(6,2000)

xx = mfcc_list_each_file[[7]]
xx = xx$mfcc
dim(xx)
xa7 = xx[,1]
xb7 = xx[,2]
xa7 = xa7[1:2000]
xb7 = xb7[1:2000]
yg = rep(7,2000)

xx = mfcc_list_each_file[[8]]
xx = xx$mfcc
dim(xx)
xa8 = xx[,1]
xb8 = xx[,2]
xa8 = xa8[1:2000]
xb8 = xb8[1:2000]
yh = rep(8,2000)

xx = mfcc_list_each_file[[9]]
xx = xx$mfcc
dim(xx)
xa9 = xx[,1]
xb9 = xx[,2]
xa9 = xa9[1:2000]
xb9 = xb9[1:2000]
yi = rep(9,2000)

xx = mfcc_list_each_file[[10]]
xx = xx$mfcc
dim(xx)
xa10 = xx[,1]
xb10 = xx[,2]
xa10 = xa10[1:2000]
xb10 = xb10[1:2000]
yj = rep(10,2000)

xx = mfcc_list_each_file[[11]]
xx = xx$mfcc
dim(xx)
xa11 = xx[,1]
xb11 = xx[,2]
xa11 = xa11[1:2000]
xb11 = xb11[1:2000]
yk = rep(11,2000)

xx = mfcc_list_each_file[[12]]
xx = xx$mfcc
dim(xx)
xa12 = xx[,1]
xb12 = xx[,2]
xa12 = xa12[1:2000]
xb12 = xb12[1:2000]
yl = rep(12,2000)

xx = mfcc_list_each_file[[13]]
xx = xx$mfcc
dim(xx)
xa13 = xx[,1]
xb13 = xx[,2]
xa13 = xa13[1:2000]
xb13 = xb13[1:2000]
ym = rep(13,2000)

xx = mfcc_list_each_file[[14]]
xx = xx$mfcc
dim(xx)
xa14 = xx[,1]
xb14 = xx[,2]
xa14 = xa14[1:2000]
xb14 = xb14[1:2000]
yn = rep(14,2000)

xx = mfcc_list_each_file[[15]]
xx = xx$mfcc
dim(xx)
xa15 = xx[,1]
xb15 = xx[,2]
xa15 = xa15[1:2000]
xb15 = xb15[1:2000]
yo = rep(15,2000)

x1 = c(xa1,xa2,xa3,xa4,xa5,xa6,xa7,xa8,xa9,xa10,xa11,xa12,xa13,xa14,xa15,xa1,xa2,xa3,xa4,xa5,xa6,xa7,xa8,xa9,xa10,xa11,xa12,xa13,xa14,xa15)
x2 = c(xb1,xb2,xb3,xb4,xb5,xb6,xb7,xb8,xb9,xb10,xb11,xb12,xb13,xb14,xb15,xb1,xb2,xb3,xb4,xb5,xb6,xb7,xb8,xb9,xb10,xb11,xb12,xb13,xb14,xb15)
y = c(ya,yb,yc,yd,ye,yf,yg,yh,yi,yj,yk,yl,ym,yn,yo,ya,yb,yc,yd,ye,yf,yg,yh,yi,yj,yk,yl,ym,yn,yo)

par(mfrow=c(3,1))
plot(x1)
plot(x2)
plot(y)

mx1 = matrix(x1,ncol=100)
mx2 = matrix(x2,ncol=100)
my = matrix(y,ncol=100)
X = array( c(mx1,mx2), dim=c(dim(mx1),2) )
Y = array( c(my), dim=c(dim(my),1) )
dim(X)
X
dim(Y)
Y
Xt = X/1000
Yt = Y/5
model = NULL
model = trainr(Y=Yt,
               X=Xt,
               model = model,
               network_type = "rnn",
               learningrate = 0.03,
               hidden_dim = c(50,10),
               numepochs = 500)

maxiter = model$numepochs
plot(model$error[1,])

Yp = predictr(model, Xt)
par(mfrow=c(2,1))
strConf = sprintf("%s lr:%1.2f hdim:%d
                  sig:%s",model$network_type,
                  model$learningrate, model$hidden_dim, model$sigmoid)
plot(colMeans(model$error[,1:maxiter]), type='l', xlab='Epoch',
     main = strConf, ylab='Errors')
plot(as.vector(Yp), col = 'red', type='l',
     main = "Actual vs Predicted on Training Data Set",
     ylab = "Yt, Yp")
lines(as.vector(Yt), type = 'l', col = 'black')







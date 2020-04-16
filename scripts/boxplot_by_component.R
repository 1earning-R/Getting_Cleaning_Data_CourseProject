par(mfrow=c(3,1))

my_data <- my_data

boxplot(tBodyGyro.mean.X ~ activity, data=my_data,col=sample(colors(),1),
        par(mar=c(1,4,3,1)),main = "Time Domain Angular Velocity by Component",
        xlab="",ylab = "X")

boxplot(tBodyGyro.mean.Y ~ activity, data=my_data,col=sample(colors(),1),
        par(mar=c(2,4,2,1)),xlab="",ylab = "Y")

boxplot(tBodyGyro.mean.Z ~ activity, data=my_data,col=sample(colors(),1),
        par(mar=c(3,4,1,1)),xlab="Activity",ylab = "Z")
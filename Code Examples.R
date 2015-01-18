
#install.packages("quantmod")
require(quantmod)




barChart(AAC.AX)
addADX(n=7)  

aa <- data.frame(AAC.AX)  




## Not run:
getSymbols(’QQQQ’,src=’yahoo’)
q.model = specifyModel(Next(OpCl(QQQQ)) ~ Lag(OpHi(QQQQ),0:3))
buildModel(q.model,method=’lm’,training.per=c(’2006-08-01’,’2006-09-30’))
## End(Not run)



chartSeries(AAC.AX,
            type = c("auto", "candlesticks", "matchsticks", "bars","line"),
            subset = NULL,
            show.grid = TRUE,
            name = NULL,
            time.scale = NULL,
            log.scale = FALSE,
            TA = "addVo()",
            TAsep=';',
            line.type = "l",
            bar.type = "ohlc",
            theme = chartTheme("black"),
            layout = NA,
            major.ticks='auto', minor.ticks=TRUE,
            yrange=NULL,
            plot=TRUE,
            color.vol = TRUE, multi.col = FALSE)






library(cricketdata)
library(svglite)

competitions <- c("tests", "t20s", "odis")

cricket <- setNames(
  vector("list", length(competitions)),
  competitions
)

for (competition in competitions) {
  bbbm <- fetch_cricsheet("bbb", "male", competition)
  bbbf <- fetch_cricsheet("bbb", "female", competition)

  bbbm[["gender"]] <- "male"
  bbbf[["gender"]] <- "female"

  bbb <- rbind(bbbm, bbbf)

  bbb <- transform(
    bbb,
    year = as.integer(substr(start_date, 1, 4)),
    competition = competition,
    # decimal notation for "overs"
    over = floor(ball),
    runs = runs_off_bat + extras
  )

  bbb <- aggregate(
    runs ~ match_id + competition + gender + year + innings + over,
    data = bbb,
    FUN = sum
  )

  cricket[[competition]] <- bbb
}

remove(competition, bbbm, bbbf, bbb)

cricket <- do.call(rbind, cricket)
rownames(cricket) <- NULL

svglite(
  "figures/cricket.svg",
  width = 6,
  height = 6 * (700 / 1050),
  user_fonts = list(mono = "fonts/SourceCodePro-VariableFont_wght.ttf")
)

par(
  tcl = -0.4,
  bty = "n",
  family = "mono",
  mar = c(1.5, 3.5, 0, 0),
  mgp = c(1, 0, 0)
)

bp <- boxplot(
  runs ~ competition + gender,
  data = cricket,
  horizontal = TRUE,
  plot = FALSE
)

plot.new()
plot.window(
  xlim = c(0, max(bp[["stats"]][5, ])),
  ylim = c(0.5, 6.5)
)

grid(ny = NA)

bxp(
  bp,
  horizontal = TRUE,
  outline = FALSE,
  xaxt = "n",
  yaxt = "n",
  ylab = "",
  boxfill = rep(c("#959595", "white"), 3),
  add = TRUE
)

axis(1, lwd = 0, lwd.ticks = 0, col.axis = "gray60", cex.axis = 0.9)

axis(
  2,
  at = c(1.5, 3.5, 5.5),
  labels = toupper(rev(competitions)),
  lwd = 0,
  lwd.ticks = 0,
  las = 1,
  cex.axis = 1.2
)

text(
  x = bp[["stats"]][4, c(5, 6)],
  y = c(5, 6) + 0.4,
  labels = c("Female", "Male"),
  adj = c(-0.2, 1),
  cex = 0.9
)

dev.off()

function drawArrow(p1,p2,text,color)

plot([p1(1), p2(1)], [p1(2), p2(2)],color,'LineWidth',2)

pnew = 0.3*(p2-p1);
alfa = 170*3.141592/180.;
rot=[cos(alfa) -sin(alfa); sin(alfa) cos(alfa)];
pnew=pnew*rot;
plot([p2(1), pnew(1)+p2(1)], [p2(2), pnew(2)+p2(2)],color,'LineWidth',2)

pnew2 = 0.3*(p2-p1);
alfa = 190*3.141592/180.;
rot=[cos(alfa) -sin(alfa); sin(alfa) cos(alfa)];
pnew2=pnew2*rot;
plot([p2(1), pnew2(1)+p2(1)], [p2(2), pnew2(2)+p2(2)],color,'LineWidth',2)
plot([pnew(1)+p2(1), pnew2(1)+p2(1)], [pnew(2)+p2(2), pnew2(2)+p2(2)],color,'LineWidth',2)

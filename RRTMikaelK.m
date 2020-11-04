clear all
close all
mindist=0.2;
start=[1,1];
set(gca,'xlim',[0 5],'ylim',[0 5])
Tree(1,:)=start(1,:);
plot(start(1,1),start(1,2),'o','MarkerFaceColor', 'b');
text(start(1,1),start(1,2),'START','Color','Blue','FontSize',8);
hold on
goal=[4,4]
distToGoal=100;
Tree(1,:)=start(1,:);
plot(goal(1,1),goal(1,2),'o','MarkerFaceColor', 'b');
text(goal(1,1),goal(1,2),'GOAL','Color','Blue','FontSize',8);

O1=[1,3;2,2.4]
xlimit1 = [O1(1,:)];
ylimit1 = [O1(2,:)];
xbox1 = xlimit1([1 1 2 2 1]);  %Making an object
ybox1 = ylimit1([1 2 2 1 1]);
mapshow(xbox1,ybox1,'DisplayType','polygon','LineStyle','-')
% 
O2=[2.5,3.9;3,3.4]
xlimit2 = [O2(1,:)];
ylimit2 = [O2(2,:)];
xbox2 = xlimit2([1 1 2 2 1]);  %Making an object
ybox2 = ylimit2([1 2 2 1 1]);
mapshow(xbox2,ybox2,'DisplayType','polygon','LineStyle','-')

O3=[2.7,3;0.6,3]
xlimit3 = [O3(1,:)];
ylimit3 = [O3(2,:)];
xbox3 = xlimit3([1 1 2 2 1]);  %Making an object
ybox3 = ylimit3([1 2 2 1 1]);
mapshow(xbox3,ybox3,'DisplayType','polygon','LineStyle','-')


O4=[0.7,1;2,3.7]
xlimit4 = [O4(1,:)];
ylimit4 = [O4(2,:)];
xbox4 = xlimit4([1 1 2 2 1]);  %Making an object
ybox4 = ylimit4([1 2 2 1 1]);
mapshow(xbox4,ybox4,'DisplayType','polygon','LineStyle','-')


O5=[3.7,4.1;1.4,3.7]
xlimit5 = [O5(1,:)];
ylimit5 = [O5(2,:)];
xbox5 = xlimit5([1 1 2 2 1]);  %Making an object
ybox5 = ylimit5([1 2 2 1 1]);
mapshow(xbox5,ybox5,'DisplayType','polygon','LineStyle','-')

%create new point
while distToGoal>0.12
    z=rand(1,2)*5;
        for jj=1:size(Tree,1) %check all vertices
            distToVert(jj)=norm(z-Tree(jj,:));
        end
        [val,ind]=min(distToVert); %which vertice(Tree(ind,:)) that is closest
        %------------adding the node---------------------------
        if val<mindist
            xlinje=[Tree(size(Tree,1),1),z(1)];
            ylinje=[Tree(size(Tree,1),2),z(2)];
            h1=isempty(polyxpoly(xlinje,ylinje,xbox1,ybox1));
            h2=isempty(polyxpoly(xlinje,ylinje,xbox2,ybox2));
            h3=isempty(polyxpoly(xlinje,ylinje,xbox3,ybox3));
            h4=isempty(polyxpoly(xlinje,ylinje,xbox4,ybox4));
            h5=isempty(polyxpoly(xlinje,ylinje,xbox5,ybox5));
            h=[h1,h2,h3,h4,h5];
            if sum(h)==5
            Tree(size(Tree,1)+1,:)=z; %new point
            xy1=Tree(ind,:);
            xy2=Tree(size(Tree,1),:);
            end
        else
            ang=atan2(z(2)-(Tree(ind,2)),(z(1)-Tree(ind,1))) ;   % tangens for angle
            balbas=mindist*[cos(ang),sin(ang)];
            xlinje=[Tree(size(Tree,1),1),Tree(ind,1)+balbas(1)];
            ylinje=[Tree(size(Tree,1),2),Tree(ind,2)+balbas(2)];
            h1=isempty(polyxpoly(xlinje,ylinje,xbox1,ybox1));
            h2=isempty(polyxpoly(xlinje,ylinje,xbox2,ybox2));
            h3=isempty(polyxpoly(xlinje,ylinje,xbox3,ybox3));
            h4=isempty(polyxpoly(xlinje,ylinje,xbox4,ybox4));
            h5=isempty(polyxpoly(xlinje,ylinje,xbox5,ybox5));
            h=[h1,h2,h3,h4,h5];
            if sum(h)==5
            Tree(size(Tree,1)+1,:)=Tree(ind,:)+balbas; %new point
            xy1=Tree(ind,:);
            xy2=Tree(size(Tree,1),:);
            end
        end
        plot([xy1(1),xy2(1)],[xy1(2),xy2(2)]) %draw from node indexK to new point
        hold on
        %plot(z(1),z(2),'o','MarkerFaceColor', 'black');
        drawnow
        axis([0 5 0 5])
        axis square
        distToGoal=norm(Tree(size(Tree,1),:)-goal);
end

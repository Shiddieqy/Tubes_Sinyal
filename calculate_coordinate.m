% P = [-1.905 2.96];
% Q = [-1.905 -3.24];
% R = [2.795 -3.24];
% S = [2.795 2.96];
X = 4.748;
Y = 6.2;
P = [0 Y];
Q = [0 0];
R = [X 0];
S = [X Y];
select = [P ;Q ;R ;S];
mode = [1 2 3];
materix = [-1.3649	0	0;
-4.5877	-3.2228	0;
-2.158	-0.7932	2.4296
];
syms x y
eqns = [sqrt((x-select(mode(2),1))^2+(y-select(mode(2),2))^2)-sqrt((x-select(mode(1),1))^2+(y-select(mode(1),2))^2)==materix(mode(1),mode(2)-1),sqrt((x-select(mode(2),1))^2+(y-select(mode(2),2))^2)-sqrt((x-select(mode(3),1))^2+(y-select(mode(3),2))^2)==materix(mode(2),mode(3)-1)];
S = solve(eqns,[x y]);
res = [double(S.x) double(S.y)]

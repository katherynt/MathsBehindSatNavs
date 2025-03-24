clear;

%% Store initial values

% distances to neighbours of each vertex
M = [ 0 4 inf inf 7 inf ;
4 0 5 inf inf 3 ;
inf 5 0 6 inf inf ;
inf inf 6 0 8 5 ;
7 inf inf 8 0 6 ;
inf 3 inf 5 6 0 ] ;

% start and end points
s=1;
z=4;

% size of M
n=size(M,1);

%initialise vectors of unvisited and visited vertices.
vis = zeros(1,n);

%initialise distances stored to each vertex
dist = Inf(1,n);
dist(s) = 0;

%initialise vector storing route
route = zeros(1,n);
route(s)=s;

%initialise iteration counter
iter=1;

%first visited vertex

I=s;

%% Run the algorithm

while I~=z %perform iterations of algorithm until end vertex met

neigh=M(I,:); %store vector of neighbouring vertices

for i=1:n

 if neigh(i)+dist(I)<dist(i) %test for potential shorter distance
 dist(i)=neigh(i)+dist(I); %update dist where shorter distance found
 route(i)=I; %update route where found

end
end

vis(I)=inf; %store the visited vertex as infinity

I = find(dist+vis==min(dist+vis));
I=I(1); %find vertex to be visited

end

route

%% Present result

fprintf('The shortest path between the selected start and end vertices has a weight of %d units. ',dist(I)) %present shortest path found

%Order route
k=route(z);
r=[z];
while k~=s
r=[k,r];
k=route(k);
end

r=[k,r];

fprintf('A path which achieves this total weight is %d, %d, %d, %d.',r)

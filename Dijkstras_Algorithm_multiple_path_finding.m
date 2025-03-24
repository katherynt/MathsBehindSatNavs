clear;
%% Store initial values

% distances to neighbours of each vertex 
M   = [    0       4       inf     inf     7       inf      ;
           4       0       5       inf     inf     3      ;
           inf     5       0       6       inf     inf      ;
           inf     inf     6       0       8       10       ;
           7       inf     inf     8       0       6        ;
           inf     3       inf     10      6       0      ] ;

M = [ 0 4 inf inf 7 inf ;
4 0 5 inf inf 3 ;
inf 5 0 6 inf inf ;
inf inf 6 0 8 5 ;
7 inf inf 8 0 6 ;
inf 3 inf 5 6 0 ] ;

% this graph is an alteration to the main example of the project to create
% two shortest path solutions between vertex 1(A) and vertex 4(D).The edge
% D-F now has weight of 10 instead of 5 previously assigned. 


% start and end points 
s=1;
z=7;

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

%perform iterations of algorithm

while I~=z %perform iterations of algorithm until end point met

neigh=M(I,:); %store vector of neighbouring vertices

for i=1:n 

    if neigh(i)+dist(I)<dist(i) %test for potential shorter distance
     dist(i)=neigh(i)+dist(I); %update dist where shorter distance found
     route(:,i)=I; %update route where found
     route=unique(route,'rows'); %only take unique routes %If multiple equal larger paths already stored as routes

    elseif neigh(i)+dist(I)==dist(i) && dist(i) ~= inf && neigh(i) ~= 0 %dont want to update zero or infinite routes
    
    newroute=route; %extact routes already calculated
    newroute(:,i)=I; %alter to new equal path to i calculated
    newroute=unique(newroute,'rows'); %extract unique paths % required if more than two shortest paths to i
    route=[route; newroute]; %add new routes to store of previously calculated routes
    
    end

end

vis(I)=inf; %store the visited vertex as infinity

I = find(dist+vis==min(dist+vis)); 
I=I(1); %find vertex to be visited

end


%% Present result

fprintf('The shortest path between the selected start and end vertices is %d units. ',dist(z)) %present shortest path found

%Order route
k=route(1,z);
r=[z];

while k~=s
r=[k,r];
k=route(1,k);
end

r=[k,r];

fprintf('A path which achieves this total weight is: %d, %d, %d, %d.',r)

p=[r];

for q=2:size(route,1)
 
    k=route(q,z);
    r=[z];

 while k~=s
 r=[k,r];
 k=route(q,k);
 end

 r=[k,r];  

fprintf(' An alternative path which achieves this total weight is: %d, %d, %d, %d, %d.',r)

end


function objectvalue=Camtilever(X)

%ai: 0.01~100

x1=X(1);
x2=X(2);
x3=X(3);
x4=X(4);
x5=X(5);

if  61/(x1^3)+37/(x2^3)+19/(x3^3)+7/(x4^3)+1/(x5^3)-1<=0
    
    objectvalue=0.0624*(x1+x2+x3+x4+x5);
    
else
    
    objectvalue=200000;
    
end
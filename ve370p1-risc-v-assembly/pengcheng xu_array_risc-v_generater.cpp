#include <iostream>
using namespace std;
int main() {
    const int n=50;//n>3
    int Array[n]={-68,-66,-64,-62,-60,-58,-56,-54,-52,-50,-48,-46,-44,-42,-40,-38,-36,-34,-32,-60,-56,-52,-48,-44,-40,-60,-54,-48,-63,-55,48,46,61,57,53,63,57,63,55,57,-7,11,2,-4,-2,8,6,2,3,1};

    cout<<"addi    a4,x0,"<<Array[0]<<endl;
    cout<<"sw      a4,0(a5)"<<endl;
    cout<<"addi    a5,a5,4"<<endl;
    cout<<"addi    a4,t1,-1"<<endl;
for(int i=1;i<n-2;i++){
    cout<<"addi    a3,x0,"<<Array[i]<<endl;
    cout<<"sw      a3,0(a5)"<<endl;
    cout<<"addi    a5,a5,4"<<endl;
    cout<<"addi    a4,a4,-1"<<endl;
}


    cout<<"addi    a3,x0,"<<Array[n-2]<<endl;
    cout<<"sw      a3,0(a5)"<<endl;
    cout<<"addi    a5,a5,4"<<endl;
    cout<<"addi    a3,a4,-1"<<endl;

    cout<<"addi    a4,x0,"<<Array[n-1]<<endl;
    cout<<"sw      a4,0(a5)"<<endl;
    cout<<"addi    a4,a5,4"<<endl;
    cout<<"addi    a5,a3,-1"<<endl;
//paste the out put to, the 6-5p1-final+++.s file,to replace the 70-th line to 120-th line"############################"

    //std::cout << "Hello, World!" << std::endl;
    return 0;
}

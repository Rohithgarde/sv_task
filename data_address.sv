//create a class cnstr_1 containing two random variables, 8bit data and 4bit
//data address. create a constraint block that keeps addresses to 3 or 4.
//in an initial block construct an cnstr_1 object and randomize it. check
//status from randomization.

class cnstr_1;
rand bit [7:0] data;
rand bit [3:0] address;
constraint c1 {
address inside {[3:4]};
}
endclass

module tb;
  bit x;
initial begin
cnstr_1 c=new();
repeat(10) begin
x=c.randomize();
if (x==1) begin
  $display("randomization success");
  $display("address value =%0d",c.address);
  end
else $display("randomization failed");
end
end
endmodule


// 2.Modify the solution for cnstr_1 to create a new class cnstr_2 so that:
// a. data is always equal to 5
// b. The probability of address==0 is 10%
// c. The probability of address being between [1:14] is 80%
// d. The probability of address==15 is 10%
// Generate 30 new address and verify the constraint

class cnstr_2;
rand bit [7:0] data;
rand bit [3:0] address;
constraint c1 {
data inside {5};
  address dist {0:/10, [1:14]:/80, 15:/10};
}
endclass

module tb;
  bit x;
initial begin
cnstr_2 c=new();
repeat(30) begin
x=c.randomize();
 if (x==1) begin 
   $display("randomization success");
   $display("dat value=%0d, address value =%0d",c.data, c.address);
 end
 else $display("randomization failed");
end
end
endmodule


// 3. Create a testbench that randomizes the cnstr_2 class 1000 times. 
// a. Count the number of times each address value occurs and print the results in a histogram. Do you see an exact 10% / 80% / 10% distribution? Why or why not? 
// b. Run the simulation with 3 different random seeds, creating histograms, and then comment on the results.



class cnstr_2;
rand bit [7:0] data;
rand bit [3:0] address;
constraint c1 {
data inside {5};
  address dist {0:/10, [1:14]:/80, 15:/10};
}

endclass

module tb;
  bit x;
  bit [7:0] arr[$];
  int zero_cnt, rng_count, fifteen_cnt;
initial begin
cnstr_2 c=new();
  repeat(1000) begin
x=c.randomize();
arr.push_back(c.address);
end
  $display("arr = %0p",arr);
  for(int i=0; i<1000; i++) begin
    if(arr[i]==0) zero_cnt++;
    else if(arr[i]==15) fifteen_cnt++;
    else rng_count++;
  end
  $display("zero_address=%0d, range_address=%0d, fifteen_address=%0d",zero_cnt,rng_count,fifteen_cnt);
end
endmodule


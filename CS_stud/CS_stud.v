`timescale 1ns/10ps
module CS(Y, X, reset, clk, appr, avg);
input clk, reset;
input [7:0] X;
output reg [9:0] Y;
output reg [7:0] appr;
output reg [7:0] avg;

reg [7:0] queue [0:8];
// for storing the 9 input items, 8-bit item
reg [11:0] sum;
// for storig the sum of 9 items
reg [7:0] temp;
reg [10:0] min;

integer i;

always@(posedge clk or posedge reset)
begin
    if (reset == 1'b1)
    begin

        for (i=0; i<9; i=i+1'b1)
            queue[i]=0;
        avg=0;
        appr=0;
        sum=0;
        min=8'b11111111;

        temp=0;

    end
    else
    begin
        avg=0;
        appr=0;
        sum=0;
        min=8'b11111111;
        temp=0;
        for (i=0; i<8; i=i+1'b1)
        begin
            queue[i]=queue[i+1];// shift the stored item
            sum=sum+queue[i];// sum up the first 8 items

        end
        // store the new input item
        queue[8]=X;
        // add the 9th item

        avg=(sum+queue[8])/9;
        // calculate the average

        for (i=0; i<9; i=i+1'b1)
        begin
            if(queue[i]<=avg)
            begin
                temp=avg-queue[i];
                if(temp<=min)
                begin
                    appr=queue[i];
                    min=temp;
                end

            end




        end
        // find the approximate average

        #5;
        Y=(sum+queue[8]+9*appr)/8;
        // calaulate the output
        // divided by 8
    end
end
endmodule

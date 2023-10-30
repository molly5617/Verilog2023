`timescale 1ns/10ps
module avg(clk,reset,din,ready,dout);
input clk,reset;
input [15:0] din;
output reg ready;
output reg [15:0] dout;

reg [15:0] queue [11:0];

reg [3:0] count;
reg [19:0] sum;
reg [15:0] average;

reg [15:0] min;
reg [15:0] ans;
integer i;

always @(posedge clk or posedge reset)
begin
    if(reset == 1'b1)
    begin
        ready =1'b0;
        dout=16'd0;
        count=4'd0;
        sum=20'd0;
    end
    else
    begin
        if (count <= 4'd10)
        begin
            queue[count]=din;
            sum=sum+queue[count];
            count=count+4'd1;
            if(count == 4'd11)
                #10 ready =1'b1;
        end
        else
        begin
            if(count == 4'd12)
            begin
                sum=sum-queue[0];
                for (i = 0;i<11 ;i=i+1)
                begin
                    queue[i]=queue[i+1];
                end
                count=count-4'd1;
            end
            queue[11]=din;
            sum=sum+queue[11];
            count=count+4'd1;
            average=sum/12;
            min=16'hffff;
            for(i=0;i<12;i=i+1)
            begin
                if(average >= queue[i])
                begin
                    if(average-queue[i]<=min)
                    begin
                        min=average-queue[i];
                        ans=queue[i];
                    end
                end
                else
                begin
                    if((queue[i]-average)<min)
                    begin
                        min=queue[i]-average;
                        ans=queue[i];
                    end
                end
            end
            #2 dout=ans;
        end
    end
end
endmodule






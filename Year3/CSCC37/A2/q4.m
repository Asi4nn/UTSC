%fprintf('%s\t%s\t%s\t\t%s\t\t%s\n','n','rcnd','re0', 'rr0', 'ref');
data = cell(0, 5);
data = cell2table(data);
data.Properties.VariableNames = ["n" "rcnd" "re0" "rr0" "ref"];

for n = 4:15
    [rcnd,x0,re0,rr0,xf,ref] = badsys(n);
    row = array2table([n rcnd re0 rr0 ref]);
    row.Properties.VariableNames = ["n" "rcnd" "re0" "rr0" "ref"];
    data = [data;row];
    %fprintf('%d\t%4.12f\t%4.12f\t%4.12f\t%4.12f\n', n, rcnd, re0, rr0, ref);
end

disp(data);
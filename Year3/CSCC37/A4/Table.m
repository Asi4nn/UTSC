data = cell(0, 2);
data = cell2table(data);
data.Properties.VariableNames = ["c" "rcnd"];

for n = 0:12
    c = n / 2;
    rcnd = Q3b(c);
    row = array2table([c rcnd]);
    row.Properties.VariableNames = ["c" "rcnd"];
    data = [data;row];
end

disp(data);
# Example test given in the question
n = 3
p = [90, 80, 40]
x = 1000

def f(n: int):
  if n <= 400:
    return 1
  else:
    return 20

def Sell_Stocks(days, stocks, p, f):
  opt = [[0 for i in range(stocks + 1)] for i in range(days + 1)] # opt table
  s = [[0 for i in range(stocks + 1)] for i in range(days + 1)] # price drop table
  a = [[0 for i in range(stocks + 1)] for i in range(days + 1)] # stocks sold for each entry

  for i in range(days + 1):
    if i == 0: # use day 0 as all 0's for the algo
      continue
    
    # iterate through every number of stocks to have sold by day i
    for j in range(stocks + 1):
      max_revenue = 0
      drop = 0
      sold = 0
      # get max income for each stock value j to have sold by day i
      for k in range(j + 1):
        revenue = opt[i - 1][j - k] + k * (p[i - 1] - s[i - 1][j - k] - f(k))
        if revenue > max_revenue:
          max_revenue = revenue
          drop = s[i - 1][j - k] + f(k)
          sold = k

      opt[i][j] = max_revenue
      s[i][j] = drop
      a[i][j] = sold

  # backtracking
  indices = [stocks]
  sold = []
  for d in range(days):
    sold.append(a[days - d][indices[d]])
    indices.append(indices[d] - sold[d])

  sold.reverse() # ans is in reverse order
  return sold

print(Sell_Stocks(n, x, p, f))

#include <stdio.h>

int qSearch(int arr[], int value, int low, int high)
{
	while (high >= 1)
	{
		int firstq = low + ((high - low) / 4);
		int secondq = low + ((high - low) / 2);
		int thirdq = low + (3 * (high - low) / 4);
		if (arr[firstq] == value)
		{
			return firstq;
		}
		else if (arr[secondq] == value)
		{
			return secondq;
		}
		else if (arr[thirdq] == value)
		{
			return thirdq;
		}
		else if (arr[firstq] > value)
		{
			return qSearch(arr, value, low, firstq - 1);
		}
		else if (arr[secondq] > value)
		{
			return qSearch(arr, value, firstq + 1, secondq - 1);
		}
		else if (arr[thirdq] > value && value > arr[secondq])
		{
			return qSearch(arr, value, secondq + 1, thirdq - 1);
		}
		else
		{
			return qSearch(arr, value, thirdq + 1, high);
		}
	}
}

int main()
{
	int arr[] = {1, 1, 1, 1, 2};
	int find = 2;
	int index = qSearch(arr, find, 1, 2);
	printf("%d", index);
}
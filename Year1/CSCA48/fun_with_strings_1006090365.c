#include<stdio.h>
#include<ctype.h>

int len(char s[])
{
	int l = 0;
	for (int i = 0; s[i] != '\0'; i++)
	{
		l++;
	}
	return l;
}

char * pidgin(char s[])
{
	int length = len(s);
	char placeholder;
	for (int i = 0; i < length; i = i + 2)
	{
		if (s[i] != '\0' && s[i + 1] != '\0')
		{
			placeholder = s[i];
			s[i] = s[i + 1];
			s[i + 1] = placeholder;
		}
	}
	
	return s;
}

char * vowel_caser(char s[])
{
	int length = len(s);
	for (int i = 0; i < length; i++)
	{
		if(s[i] == 'A' || s[i] == 'E' || s[i] == 'I' || s[i] == 'O' || s[i] == 'U')
		{
			s[i] = tolower(s[i]);
		}
		else if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u')
		{
			s[i] = toupper(s[i]);
		}
	}
	
	return s;
}

int main()
{
	char string[] = "A strIng is jUst a bunch Of chArs sittIng togEthEr in A row!";
	printf("%s\n", string);
	printf("%s\n", pidgin(string));
	printf("%s\n", vowel_caser(string));

	return 0;
}
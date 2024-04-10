#include "libft.h"

int	ft_memcmp(const void *s1, const void *s2, size_t n)
{
	int i;
	char *str1;
	char *str2;

	if (n == 0)
		return 0;
	str1 = (char *) s1;
	str2 = (char *) s2;
	i = 0;
	while (str1[i] && str1[i] == str2[i] && i < (n - 1))
		i++;
	return ((unsigned char) str1[i] - (unsigned char) str2[i]);
}
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hana/hmori <hmori@student.42tokyo.jp>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/08 18:06:02 by hana/hmori        #+#    #+#             */
/*   Updated: 2025/07/08 17:22:14 by hana/hmori       ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "ft/stdio.h"
#include "minirt.h"
#include "rt_viewer.h"

void	a(void *vars)
{
	printf("success !\n");
	(void)vars;
}

int	main(int argc, char *argv[])
{
	void	*vars;

	if (argc != 2)
		return (ret_errmsg(EXIT_FAILURE, USAGE_MSG));
	vars = mrt_init();
	if (vars == NULL)
	{
		if (errno)
			perror("mrt_init");
		return (EXIT_FAILURE);
	}
	if (0 < mrt_read_file(vars, argv[1]))
		a(vars);
	else if (errno)
		perror("mrt_read_file");
	mrt_destroty(vars);
	return (EXIT_SUCCESS);
}

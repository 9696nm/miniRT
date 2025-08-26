/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hana/hmori <hmori@student.42tokyo.jp>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/08 18:06:02 by hana/hmori        #+#    #+#             */
/*   Updated: 2025/08/26 15:32:55 by hana/hmori       ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt_viewer.h"

int	window_destroy(t_graph *vars)
{
	ft_putstr_fd("window close\n", STDOUT_FILENO);
	mlx_destroy_image(vars->mlx, vars->idata.img);
	return (mlx_loop_end(vars->mlx));
}

void	minirt_display(const char *name, t_graph *vars)
{
	printf("success !\n");
	vars->mlx = mlx_init();
	vars->win = mlx_new_window(vars->mlx, WIDTH, HEIGHT, (char *)name);
	vars->idata.img = mlx_new_image(vars->mlx, WIDTH, HEIGHT);
	vars->idata.addr = mlx_get_data_addr(vars->idata.img,
			&vars->idata.bits_per_pixel, &vars->idata.size_line,
			&vars->idata.endian);
	mlx_hook(vars->win, DestroyNotify, StructureNotifyMask,
		window_destroy, vars);
	mlx_loop_hook(vars->mlx, mrt_loop, vars);
	mlx_loop(vars->mlx);
	mlx_destroy_window(vars->mlx, vars->win);
	mlx_destroy_display(vars->mlx);
	free(vars->mlx);
}

int	main(int argc, char *argv[])
{
	t_graph	vars;

	if (argc != 2)
		return (ret_errmsg(EXIT_FAILURE, USAGE_MSG));
	vars.scene = mrt_init();
	if (vars.scene == NULL)
	{
		if (errno)
			perror("mrt_init");
		return (EXIT_FAILURE);
	}
	if (0 < mrt_read_file(argv[1], vars.scene))
		minirt_display(argv[1], &vars);
	else if (errno)
		perror("mrt_read_file");
	mrt_destroty(vars.scene);
	return (EXIT_SUCCESS);
}

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

static int	window_destroy(t_graph *vars)
{
	ft_putstr_fd("window close\n", STDOUT_FILENO);
	return (mlx_loop_end(vars->mlx));
}

static int	key_press(int keycode, t_graph *vars)
{
	if (keycode == XK_Escape)
		return (window_destroy(vars));
	else if (keycode == XK_n)
		;
	else
		return (0);
	vars->gfx_flags |= (1u << RE_GRAPHIC);
	return (0);
}

static int	graphic_loop(t_graph *vars)
{
	if (vars->gfx_flags & (1u << RE_GRAPHIC))
	{
		vars->gfx_flags &= ~(1u << RE_GRAPHIC);
		mrt_image_clear_mlx(vars->img, WIDTH, HEIGHT);
		mrt_image_render_mlx(vars->scene, vars->img, WIDTH, HEIGHT);
		mlx_put_image_to_window(vars->mlx, vars->win, vars->img, 0, 0);
	}
	return (0);
}

static void	graphic_setup(const char *name, t_graph *vars)
{
	vars->mlx = mlx_init();
	vars->win = mlx_new_window(vars->mlx, WIDTH, HEIGHT, (char *)name);
	vars->img = mlx_new_image(vars->mlx, WIDTH, HEIGHT);
	vars->gfx_flags = (1u << RE_GRAPHIC);
	mlx_hook(vars->win, KeyPress, KeyPressMask, key_press, vars);
	mlx_hook(vars->win, DestroyNotify, StructureNotifyMask,
		window_destroy, vars);
	mlx_loop_hook(vars->mlx, graphic_loop, vars);
	mlx_loop(vars->mlx);
	mlx_destroy_image(vars->mlx, vars->img);
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
	if (0 < mrt_read_file(vars.scene, argv[1]))
		graphic_setup(argv[1], &vars);
	else if (errno)
		perror("mrt_read_file");
	mrt_destroty(vars.scene);
	return (EXIT_SUCCESS);
}

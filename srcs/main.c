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
	// if (keycode == XK_Up)
	// 	vars->arrof = crd_off_move(vars->rqv, vars->arrof, (t_vec3){0, 1, 0});
	// else if (keycode == XK_Down)
	// 	vars->arrof = crd_off_move(vars->rqv, vars->arrof, (t_vec3){0, -1, 0});
	// else if (keycode == XK_Left)
	// 	vars->arrof = crd_off_move(vars->rqv, vars->arrof, (t_vec3){1, 0, 0});
	// else if (keycode == XK_Right)
	// 	vars->arrof = crd_off_move(vars->rqv, vars->arrof, (t_vec3){-1, 0, 0});
	// else if (keycode == XK_period)
	// 	vars->arrof.z_elast += 0.1;
	// else if (keycode == XK_comma)
	// 	vars->arrof.z_elast -= 0.1;
	// else if (keycode == XK_slash)
	// 	vars->gflag.fl ^= (1 << TOGGLE_PERSPECTIVE);
	// else if (keycode == XK_0)
	// 	parameter_init(vars);
	else if (keycode == XK_n)
		;
	else
		return (0);
	vars->gfx_flags |= (1u << RE_GRAPHIC);
	return (0);
}

#include <time.h>	//
#include <sys/time.h>	//
static int	graphic_loop(t_graph *vars)	// !debug
{
	struct timeval	start_time, end_time;	//
	struct timespec	start_clock, end_clock;	//

	if (vars->gfx_flags & (1u << RE_GRAPHIC))
	{
		gettimeofday(&start_time, NULL);	//
		clock_gettime(CLOCK_MONOTONIC, &start_clock);	//
	
		vars->gfx_flags &= ~(1u << RE_GRAPHIC);
		mrt_image_clear_mlx(vars->img, WIDTH, HEIGHT);
		mrt_image_render_mlx(vars->scene, vars->img, WIDTH, HEIGHT);
		mlx_put_image_to_window(vars->mlx, vars->win, vars->img, 0, 0);
	
		gettimeofday(&end_time, NULL);	//
		clock_gettime(CLOCK_MONOTONIC, &end_clock);	//
		printf("time :%.6f\n", (end_time.tv_sec - start_time.tv_sec) +
			(end_time.tv_usec - start_time.tv_usec) / 1000000.0);	//
		printf("clock:%.6f\n", (end_clock.tv_sec - start_clock.tv_sec) +
			(end_clock.tv_nsec - start_clock.tv_nsec) / 1e9);	//
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

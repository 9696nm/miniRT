/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rt_viewer.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hana/hmori <hmori@student.42tokyo.jp>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/07/26 13:40:56 by hana/hmori        #+#    #+#             */
/*   Updated: 2025/08/26 15:19:56 by hana/hmori       ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef RT_VIEWER_H
# define RT_VIEWER_H

# include <errno.h>
# include <stdio.h>
# include <stdlib.h>
# include <unistd.h>

# include <X11/X.h>
# include <X11/keysym.h>
# include <X11/keysymdef.h>

# include <mlx.h>

# include "ft/stdio.h"
# include "minirt.h"

# define USAGE_MSG "Usage: ./miniRT [scene_file.rt]\n"

typedef enum e_displaysize
{
	WIDTH = 1920,
	HEIGHT = 1080
}	t_dsize;

typedef enum e_glaphic_flags
{
	RE_GRAPHIC,
	MOUSE_PRESS,
	TOGGLE_PERSPECTIVE
}	t_gfx_flags;

typedef struct s_graphic
{
	void			*scene;
	void			*mlx;
	void			*win;
	void			*img;
	unsigned int	gfx_flags;
}	t_graph;

#endif /* RT_VIEWER_H */
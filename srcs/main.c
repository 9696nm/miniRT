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

#include <stdlib.h>
#include "minirt.h"

int	main(void)
{
	void	*vars;

	vars = mrt_init();
	mrt_set_value(vars, "nofile");
	mrt_destroty(vars);
	return (EXIT_SUCCESS);
}

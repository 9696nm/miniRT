/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   quaternion.h                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hana/hmori <hmori@student.42tokyo.jp>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/09/05 20:53:20 by hana/hmori        #+#    #+#             */
/*   Updated: 2025/06/17 13:25:16 by hana/hmori       ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef QUATERNION_H
# define QUATERNION_H

# include <math.h>
# include "q_rsqrt.h"

typedef struct s_vecter3
{
	float	x;
	float	y;
	float	z;
}	t_vec3;

typedef struct s_quaternion
{
	float	w;
	t_vec3	v;
}	t_quater;

/* quaternion.c */ 
t_quater	quater_normalize(t_quater q);
t_quater	quater_multiply(t_quater q1, t_quater q2);
t_quater	quater_conjugate(const t_quater q);
t_quater	quater_rotate(t_quater qv, t_quater q);
t_quater	quater_axis_angle(float x, float y, float z, float angle);

#endif /* QUATERNION_H */

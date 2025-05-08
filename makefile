# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hana/hmori <hmori@student.42tokyo.jp>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/24 15:14:11 by hana/hmori        #+#    #+#              #
#    Updated: 2025/05/08 18:10:10 by hana/hmori       ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			=	miniRT


CC				=	cc
FLAGS			=	-I$(INCLUDES_DIR) -I$(LIBFT_DIR)/$(INCLUDES_DIR) -I$(MLX_DIR)
CFLAGS			=	-Wall -Wextra -Werror
LIBX_FLAGS		=	-Imlx -lXext -lX11 -lm
MAKEFLAGS		+=	--no-print-directory

LIBFT_DIR		=	libft
LIBFTA			=	$(LIBFT_DIR)/libft.a

MLX_DIR			=	minilibx-linux
LIBMLXA			=	$(MLX_DIR)/libmlx_Linux.a


INCLUDES_DIR	=	includes

SRCS_DIR		=	./srcs
SRC_FILES		=	

OBJS_DIR 		=	./objs
OBJS 			=	$(patsubst %.c, $(OBJS_DIR)/%.o, $(SRC_FILES))
DEPENDENCY		=	$(patsubst %.c, $(OBJS_DIR)/%.d, $(SRC_FILES))


RED				=	"\033[1;31m"
GREEN			= 	"\033[1;32m"
YELLOW			=	"\033[1;33m"
CYAN			=	"\033[1;36m"
WHITE			=	"\033[1;37m"
RESET			=	"\033[0m"


all: $(LIBFT_DIR) $(MLX_DIR) $(NAME)

$(NAME): $(OBJS) $(LIBFTA)
	$(CC) $(FLAGS) $(CFLAGS) $(OBJS) $(LIBFTA) $(LIBMLXA) -o $@ $(LIBX_FLAGS)
	@echo $(GREEN)"---$(FLAG) Compiling Sccusse !---"$(RESET)

$(OBJS_DIR):
	@mkdir -p $(OBJS_DIR)

$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.c | $(OBJS_DIR)
	$(CC) $(FLAGS) $(CFLAGS) -MMD -MP -c $< -o $@

-include $(DEPENDENCY)

$(LIBFT_DIR):
	@git submodule update --init --remote
	@make -C $(LIBFT_DIR)/ extra

$(MLX_DIR):
	@make -C $(MLX_DIR)/

bonus:
	@$(MAKE) all FLAG=bonus

clean:
	@make -C $(LIBFT_DIR) clean
	@if [ -d $(OBJS_DIR) ]; then \
		rm -rf $(OBJS_DIR); \
		echo $(RED)"Printf $(OBJS_DIR) deleted !"$(RESET); \
	else \
		echo $(CYAN)"Printf object is already deleted."$(RESET); \
	fi

fclean: clean
	@make -C $(LIBFT_DIR) fclean
	@make -C $(MLX_DIR) clean
	@if [ -f $(NAME) ]; then \
		rm -f $(NAME); \
		echo $(RED)"Printf $(NAME) deleted !"$(RESET); \
	else \
		echo $(CYAN)"Printf archive is already deleted."$(RESET); \
	fi

re:	fclean all

.DEFAULT_GOAL := all

.PHONY:	all bonus clean fclean re $(LIBFT_DIR) $(MLX_DIR)

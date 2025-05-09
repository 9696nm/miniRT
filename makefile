# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hana/hmori <hmori@student.42tokyo.jp>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/24 15:14:11 by hana/hmori        #+#    #+#              #
#    Updated: 2025/05/10 01:58:10 by hana/hmori       ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

TARGET			=	miniRT
PROJECT_NAME	=	miniRT

MAKEFLAGS		+=	--no-print-directory

# -compile rule-
CC				=	gcc
WARNING_FLAG	=	-Wall -Wextra -Werror
OPT_FLAGS		=	-O0
INC_PATHS		=	-I$(INCLUDES_DIR) -I$(LIBFT_DIR)$(INCLUDES_DIR) -I$(MLX_DIR)
LINK_LIBS		=	-Imlx -lXext -lX11 -lm

# -library-
LIBFT_DIR		=	libft/
LIBFTA			=	$(LIBFT_DIR)libft.a

MLX_DIR			=	minilibx-linux/
LIBMLXA			=	$(MLX_DIR)libmlx_Linux.a

# -target-
INCLUDES_DIR	=	includes/
SRCS_DIR		=	srcs/
OBJS_DIR 		=	objs/

SRC_FILES		=	main.c
OBJS 			=	$(patsubst %.c, $(OBJS_DIR)%.o, $(SRC_FILES))
DEPENDENCY		=	$(patsubst %.c, $(OBJS_DIR)%.d, $(SRC_FILES))

# -color code-
RED				=	"\033[1;31m"
GREEN			= 	"\033[1;32m"
YELLOW			=	"\033[1;33m"
CYAN			=	"\033[1;36m"
WHITE			=	"\033[1;37m"
RESET			=	"\033[0m"


# --rule--
all: $(LIBFT_DIR) $(MLX_DIR) $(TARGET)

$(TARGET): $(OBJS) $(LIBFTA)
	$(CC) $(WARNING_FLAG) $(OPT_FLAGS) $(INC_PATHS) $(OBJS) $(LIBFTA) $(LIBMLXA) -o $@ $(LINK_LIBS)
	@echo $(GREEN)"---$(FLAG) Compiling Sccusse !---"$(RESET)

$(OBJS_DIR):
	@mkdir -p $(OBJS_DIR)

$(OBJS_DIR)%.o: $(SRCS_DIR)%.c | $(OBJS_DIR)
	$(CC) $(WARNING_FLAG) $(OPT_FLAGS) $(INC_PATHS) -MMD -MP -c $< -o $@

-include $(DEPENDENCY)

$(LIBFT_DIR):
	@git submodule update --init --remote --recursive
	@make -C $(LIBFT_DIR) extra

$(MLX_DIR):
	@make -C $(MLX_DIR)

bonus:
	@$(MAKE) all FLAG=bonus

clean:
	@make -C $(LIBFT_DIR) clean
	@if [ -d $(OBJS_DIR) ]; then \
		rm -rf $(OBJS_DIR); \
		echo $(RED)"$(PROJECT_NAME) $(OBJS_DIR) deleted !"$(RESET); \
	else \
		echo $(CYAN)"$(PROJECT_NAME) object is already deleted."$(RESET); \
	fi

fclean: clean
	@make -C $(LIBFT_DIR) fclean SKIP_CLEAN=1
	@make -C $(MLX_DIR) clean
	@if [ -f $(TARGET) ]; then \
		rm -f $(TARGET); \
		echo $(RED)"$(PROJECT_NAME) $(TARGET) deleted !"$(RESET); \
	else \
		echo $(CYAN)"$(PROJECT_NAME) archive is already deleted."$(RESET); \
	fi

re:	fclean all

.DEFAULT_GOAL := all

.PHONY:	all bonus clean fclean re $(LIBFT_DIR) $(MLX_DIR)

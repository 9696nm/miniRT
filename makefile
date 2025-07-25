# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hana/hmori <hmori@student.42tokyo.jp>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/24 15:14:11 by hana/hmori        #+#    #+#              #
#    Updated: 2025/07/15 00:07:29 by hana/hmori       ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

TARGET			=	miniRT
PROJECT_NAME	=	miniRT

MAKEFLAGS		+=	--no-print-directory

# -compile rule-
CC				=	gcc
WARNING_FLAG	=	-Wall -Wextra -Werror -Wuninitialized
OPT_FLAGS		=	-O0
INC_PATHS		=	-I$(LIBFT_DIR) -I$(MLX_DIR)
LINK_LIBS		=	-lXext -lX11 -lm
DEPEND_FLAGS	=	-MMD -MP

# -library-
LIBFT_DIR		=	libft/
LIBFTA			=	$(LIBFT_DIR)libft.a

MLX_DIR			=	minilibx-linux/
LIBMLXA			=	$(MLX_DIR)libmlx_Linux.a

# -target-
INCLUDES_DIR	=	includes/
SRCS_DIR		=	srcs/
OBJS_DIR 		=	objs/

SRCS			=	main.c

OBJ_FILES		=	$(patsubst %.c, $(OBJS_DIR)%.o, $(TARGET_SRCS))
DEP_FILES		=	$(patsubst %.c, $(OBJS_DIR)%.d, $(TARGET_SRCS))

ifeq ($(COMPILE_TYPE), bonus)
TARGET_SRCS		=	$(SRCS)
else
TARGET_SRCS		=	$(SRCS)
endif

# -color code-
RED				=	"\033[1;31m"
GREEN			= 	"\033[1;32m"
YELLOW			=	"\033[1;33m"
CYAN			=	"\033[1;36m"
WHITE			=	"\033[1;37m"
RESET			=	"\033[0m"


# --rule--
-include $(DEP_FILES)

all: submodule $(LIBFT_DIR) $(LIBARITH_DIR) $(MLX_DIR) $(TARGET)

submodule:
	@git submodule update --init --remote --recursive

$(LIBFT_DIR):
	@make -C $(LIBFT_DIR) extra math

$(LIBARITH_DIR):
	@make -C $(LIBFT_DIR) DEP_INCLUDES="-I$(abspath $(LIBFT_DIR))"

$(MLX_DIR):
	@-make -C $(MLX_DIR)

$(TARGET): $(OBJ_FILES) $(LIBFTA) $(LIBMLXA)
	$(CC) $(WARNING_FLAG) $(OPT_FLAGS) $(INC_PATHS) $^ -o $@ $(LINK_LIBS)
	@echo $(GREEN)"--- $(PROJECT_NAME) Compiling Sccusse $(COMPILE_TYPE)! ---"$(RESET)

$(OBJS_DIR)%.o: $(SRCS_DIR)%.c | $(OBJS_DIR)
	$(CC) $(WARNING_FLAG) $(OPT_FLAGS) $(INC_PATHS) $(DEPEND_FLAGS) -c $< -o $@

$(OBJS_DIR):
	@mkdir -p $(OBJS_DIR)

bonus:
	@$(MAKE) all COMPILE_TYPE=bonus

clean:
	@make -C $(LIBFT_DIR) clean
	@if [ -d $(OBJS_DIR) ]; then \
		rm -rf $(OBJS_DIR); \
		echo $(RED)"$(PROJECT_NAME) $(OBJS_DIR) deleted!"$(RESET); \
	else \
		echo $(CYAN)"$(PROJECT_NAME) object is already deleted."$(RESET); \
	fi

fclean: clean
	@make -C $(LIBFT_DIR) fclean SKIP_CLEAN=1
	@make -C $(MLX_DIR) clean
	@if [ -f $(TARGET) ]; then \
		rm -f $(TARGET); \
		echo $(RED)"$(PROJECT_NAME) $(TARGET) deleted!"$(RESET); \
	else \
		echo $(CYAN)"$(PROJECT_NAME) archive is already deleted."$(RESET); \
	fi

re:	fclean all

.DEFAULT_GOAL := all

.PHONY:	all bonus clean fclean re submodule $(LIBFT_DIR) $(MLX_DIR)

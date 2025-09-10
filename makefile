# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hana/hmori <hmori@student.42tokyo.jp>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/24 15:14:11 by hana/hmori        #+#    #+#              #
#    Updated: 2025/08/26 15:10:43 by hana/hmori       ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# miniRT build
TARGET			=	miniRT
PROJECT_NAME	=	miniRT

MAKEFLAGS		+=	--no-print-directory

.DEFAULT_GOAL	:= all


# -compile rule-
CC				=	gcc
WARNING_FLAGS	=	-Wall -Wextra -Werror -Wuninitialized
OPT_FLAGS		=	-O0
INC_PATHS		=	$(addprefix -I,$(INC_DIR))

LIB_PATHS		=	$(addprefix -L,$(LIB_DIR))
LIB_FLAGS		=	-lmrt -lft -larith -lmlx_Linux -lm -lXext -lX11

DEPEND_FLAGS	=	-MMD -MP

# -library-
LIBFT_DIR		=	libft/
LIBFTA			=	$(LIBFT_DIR)libft.a
LIBARITHA		=	$(LIBFT_DIR)libarith.a

LIBMINIRT_DIR	=	libminirt/
LIBMINIRTA		=   $(LIBMINIRT_DIR)libmrt.a

MLX_DIR			=	minilibx-linux/

# -target-
INC_DIR			=	includes/ $(LIBFT_DIR) $(LIBMINIRT_DIR) $(MLX_DIR)
LIB_DIR			=	$(LIBFT_DIR) $(LIBMINIRT_DIR) $(MLX_DIR)
SRC_DIR			=	srcs/
OBJ_DIR			=	objs/

# -sources-
SRCS			=	main.c

ifeq ($(COMPILE_TYPE), bonus)
TARGET_SRCS		=	$(SRCS)
else
TARGET_SRCS		=	$(SRCS)
endif

# -objects-
OBJS			=	$(patsubst %.c, $(OBJ_DIR)%.o, $(TARGET_SRCS))
DEPS			=	$(patsubst %.c, $(OBJ_DIR)%.d, $(TARGET_SRCS))

# -include-
-include $(DEPS)

# -color code-
RED				=	"\033[1;31m"
GREEN			= 	"\033[1;32m"
YELLOW			=	"\033[1;33m"
CYAN			=	"\033[1;36m"
WHITE			=	"\033[1;37m"
RESET			=	"\033[0m"


# --rule--	
all: $(LIBFT_DIR) $(LIBMINIRT_DIR) $(MLX_DIR) $(TARGET)

$(LIBFT_DIR):
	@make -C $(LIBFT_DIR) all extra arith

$(LIBMINIRT_DIR):
	@make -C $(LIBMINIRT_DIR) DEP_INCLUDES="$(abspath $(LIBFT_DIR) $(MLX_DIR))"

$(MLX_DIR):
	@-make -C $(MLX_DIR)

$(TARGET): $(OBJS)
	$(CC) $(WARNING_FLAGS) $(OPT_FLAGS) $(INC_PATHS) $^ $(LIB_PATHS) $(LIB_FLAGS) -o $@
	@echo $(GREEN)"--- $(PROJECT_NAME) compiled successfully $(COMPILE_TYPE) ---"$(RESET)

$(OBJ_DIR)%.o: $(SRC_DIR)%.c | $(OBJ_DIR)
	$(CC) $(WARNING_FLAGS) $(OPT_FLAGS) $(INC_PATHS) $(DEPEND_FLAGS) -c $< -o $@

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

bonus:
	@$(MAKE) all COMPILE_TYPE=bonus

clean:
	@make -C $(LIBFT_DIR) clean
	@make -C $(LIBMINIRT_DIR) clean
	@if [ -d $(OBJ_DIR) ]; then \
		rm -rf $(OBJ_DIR); \
		echo $(RED)"$(PROJECT_NAME) $(OBJ_DIR) has been deleted !"$(RESET); \
	else \
		echo $(CYAN)"$(PROJECT_NAME) object has already been deleted."$(RESET); \
	fi

fclean: clean
	@make -C $(LIBFT_DIR) fclean SKIP_CLEAN=1
	@make -C $(LIBMINIRT_DIR) fclean SKIP_CLEAN=1
	@make -C $(MLX_DIR) clean
	@if [ -f $(TARGET) ]; then \
		rm -f $(TARGET); \
		echo $(RED)"$(PROJECT_NAME) $(TARGET) has been deleted !"$(RESET); \
	else \
		echo $(CYAN)"$(PROJECT_NAME) archive has already been deleted."$(RESET); \
	fi

re:	fclean all

.PHONY:	all bonus clean fclean re submodule $(LIBFT_DIR) $(LIBMINIRT_DIR) $(MLX_DIR)

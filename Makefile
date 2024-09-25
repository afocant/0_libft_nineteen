# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: afocant <afocant@student.s19.be>           +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/25 14:26:45 by afocant           #+#    #+#              #
#    Updated: 2024/09/24 11:52:33 by afocant          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#---------------------------------------------------------#
CC		=	cc

CFLAGS	=	-Wall -Wextra -Werror

GFLAGS	=	-g3
#---------------------------------------------------------#
SRC_DIR		=	src

SRC_SUBDIRS	=	$(shell find $(SRC_DIR)/* -type d)

SRC			=	$(shell find $(SRC_DIR) -type f -name "*.c")

OBJ_DIR		=	obj

OBJ_SUBDIRS	=	$(SRC_SUBDIRS:$(SRC_DIR)%=$(OBJ_DIR)%)

OBJ			=	$(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
#---------------------------------------------------------#
INC_DIR		=	include

INC_FLAGS	=	-I$(INC_DIR)

DARWIN_ARM64	=	$(shell uname -a | grep Darwin | grep -E '(aarch64|arm64)')
DARWIN_X86		=	$(shell uname -a | grep Darwin | grep x86)
LINUX_ARM64		=	$(shell uname -a | grep Linux  | grep -E '(aarch64|arm64)')
LINUX_X86		=	$(shell uname -a | grep Linux  | grep x86)

ifneq ($(DARWIN_ARM64),)
	NAME	=	libft_darwin_arm64.a
else ifneq ($(DARWIN_X86),)
	NAME	=	libft_darwin_x86.a
else ifneq ($(LINUX_ARM64),)
	NAME	=	libft_linux_arm64.a
else ifneq ($(LINUX_X86),)
	NAME	=	libft_linux_x86.a
endif

.PHONY: all clean fclean re
#---------------------------------------------------------#
all: $(NAME)

$(NAME): $(OBJ)
	@ar -rcs $@ $^ 
	@echo "LIBFT has been created"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR) $(OBJ_SUBDIRS)
	@$(CC) $(CFLAGS) $(GFLAGS) $(INC_FLAGS) -c $< -o $@

$(OBJ_DIR):
	@mkdir -p $@
$(OBJ_SUBDIRS):
	@mkdir -p $@

clean:
	@rm -rf $(OBJ_DIR)
fclean: clean
	@rm -f $(NAME)
	@echo "LIBFT fully cleaned"

re: fclean all

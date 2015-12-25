/*
  Copyright (C) 2015 by Syohei YOSHIDA

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <assert.h>
#include <stdio.h>
#include <emacs-module.h>

int plugin_is_GPL_compatible;

static intmax_t
fib_loop(intmax_t n)
{
	int a = 0, b = 1;
	for (int i = 0; i < n; ++i) {
		int tmp = a;
		a = b;
		b = tmp + b;
	}

	return a;
}

static intmax_t
fib(intmax_t n)
{
	if (n <= 1)
		return n;

	return fib(n - 1) + fib(n - 2);
}

static emacs_value
Ffib_c(emacs_env *env, ptrdiff_t nargs, emacs_value args[], void *data)
{
	return env->make_integer(env, fib(env->extract_integer(env, args[0])));
}

static emacs_value
Ffib_c_loop(emacs_env *env, ptrdiff_t nargs, emacs_value args[], void *data)
{
	return env->make_integer(env, fib_loop(env->extract_integer(env, args[0])));
}

static void
bind_function(emacs_env *env, const char *name, emacs_value Sfun)
{
	emacs_value Qfset = env->intern(env, "fset");
	emacs_value Qsym = env->intern(env, name);
	emacs_value args[] = { Qsym, Sfun };

	env->funcall(env, Qfset, 2, args);
}

static void
provide(emacs_env *env, const char *feature)
{
	emacs_value Qfeat = env->intern(env, feature);
	emacs_value Qprovide = env->intern (env, "provide");
	emacs_value args[] = { Qfeat };

	env->funcall(env, Qprovide, 1, args);
}

int
emacs_module_init(struct emacs_runtime *ert)
{
	emacs_env *env = ert->get_environment(ert);

#define DEFUN(lsym, csym, amin, amax, doc, data) \
	bind_function (env, lsym, env->make_function(env, amin, amax, csym, doc, data))

	DEFUN("fib-c", Ffib_c, 1, 1, "Calculate Fibonacci number with recursive function call", NULL);
	DEFUN("fib-c-loop", Ffib_c_loop, 1, 1, "Calculate Fibonacci number with loop", NULL);
#undef DEFUN

	provide(env, "fib-core");
	return 0;
}

/*
  Local Variables:
  c-basic-offset: 8
  indent-tabs-mode: t
  End:
*/

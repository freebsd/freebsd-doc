#
# This file is intended to drive the build of the entire doc tree.  In order to
# build both the documentation and the website, one only need to execute:
#
# make all
#
# Here at the top-level of the repository.  The same target may be executed in
# the individual directories to build just the documentation or just the
# website.
#
# Note that the Makefiles within the individual components may also be used to
# spin up hugo's internal webserver for testing, by default on port 1313.  This
# can be done with the `run` target.
#

SUBDIR+=	documentation
SUBDIR+=	website

SUBDIR_PARALLEL=	yes

run:
	@(echo The 'run' target is only valid in a subdirectory; exit 1)

.include <bsd.subdir.mk>

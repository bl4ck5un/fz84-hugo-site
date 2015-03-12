+++
title = "Python Descriptor by Example"
date = "2014-03-12"
tags = ["Python", "Python descriptor"]
+++

Understand how to write and take advantage of Python descriptor by looking into product example from Django source code.

When browsing the source code of OSQA, I accidentally dipped into Django's implementation of `AuthenticationMiddleware`, the middleware attaching `user` instance to each `request` when hooked within `process_request`. Following live code from Django 1.3 could be a great illustration on how descriptor works and what makes it agile.


```python
class LazyUser(object):
    def __get__(self, request, obj_type=None):
        if not hasattr(request, '_cached_user'):
            from django.contrib.auth import get_user
            request._cached_user = get_user(request)
        return request._cached_user

class AuthenticationMiddleware(object):
    def process_request(self, request):
        assert hasattr(request, 'session'), "blah balh"
        request.__class__.user = LazyUser()
        return None
```


So, firstly, what is a `descriptor`
-----------------------------------

Abstract and vague as the official documentation is, if you read it with more concrete experience, 
you'd find it's not that bad actually.


>The following methods only apply when an instance of the class containing the method (a so-called **descriptor class**) appears in the class dictionary of another new-style class, known as the **owner class**.

**"following methods"** refers to 

- `object.__get__(self, instance, owner)` Called to get the attribute of the owner class (class attribute access) or of an instance of that class (instance attribute access). `Owner` is always the owner class, while `instance` is the instance that the attribute was accessed through, or `None` when the attribute is accessed through the owner. This method should return the (computed) attribute value or raise an AttributeError exception.
- `object.__set__(self, instance, value)` Called to set the attribute on an instance instance of the owner class to a new value.
- `object.__delete__(self, instance)` Called to delete the attribute on an instance instance of the owner class.

Now let's look into the fresh code
----------------------------------

```python
class LazyUser(object):
    """ LazyUser is a descriptor class
    """
    def __get__(self, request, obj_type=None):
        if not hasattr(request, '_cached_user'):
            from django.contrib.auth import get_user
            request._cached_user = get_user(request)
        return request._cached_user

class AuthenticationMiddleware(object):
    def process_request(self, request):
        assert hasattr(request, 'session'), "blah balh"
        # request.__class__ is the *owner class*
        # request.__class__.user refers to the *instance* of LazyUser
        request.__class__.user = LazyUser() 
        return None
```

Technically speaking, with `__get__` method defined, `class LazyUser` becomes a descriptor class and then gets assigned to `request.__class__` by hook method in `AuthenticationMiddleware`. After that `request.__class__` becomes the counterpart -- **owner** class.

Why called lazy?
-----------------

By now, we've inspected every cover of the code. However, nothing concrete has actually happened yet, all of this has nothing to do with the real `User` object (store in session) by now. In other words, the actual access to `User` object has been postponed as much as possible, until `request.user` attributed is queried (then `__get__(...)` executes and return a meaningful user object from session, but the detail is not important to current topic). That's where the name *LazyUser* comes from.

A closer look
--------------

Let's take a closer look at the parameters of `__get__` method:


```python
def __get__(self, request, obj_type=None):
```

Note that, corresponding to documentation, `object.__get__(self, instance, owner)`, we can find `instance` is used instead of `owner`. Here in our live example, `request` is the *instance* of owner class (`request.__class__`).
